import-module au

$releases32 = 'http://downloads.rclone.org/rclone-current-windows-386.zip'
$releases64 = 'http://downloads.rclone.org/rclone-current-windows-amd64.zip'
$github_releases = 'https://github.com/ncw/rclone/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge
}

function global:au_GetLatest {
     $download_page = Invoke-WebRequest -Uri $github_releases -UseBasicParsing
    
    $re = '.+windows.+\.zip$'
    $url32   = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url64   = $download_page.links | ? href -match $re | select -Skip 1 -First 1 -expand href

    $version  = ($url32 -split '/' | select -Last 1 -Skip 1) -split 'v' | select -Last 1

    @{
        Version      = $version
        URL32        = $url32
        URL64        = $url64
        ReleaseNotes = ''
    }
}

try {
    update -ChecksumFor none
} catch {
    $ignore = 'Unable to connect to the remote server'
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}