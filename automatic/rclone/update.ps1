import-module au

$github_releases = 'https://github.com/ncw/rclone/releases'

function global:au_SearchReplace {
   @{
        ".\rclone.nuspec" = @{
            '("rclone\.install"\sversion=)(".*")'  = "`$1'$($Latest.version)'"
        }
    }
}
function global:au_BeforeUpdate {
    
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $github_releases -UseBasicParsing
    
    $re = '.+windows.+\.zip$'
    $url32   = "https://github.com$($download_page.links | ? href -match $re | select -First 1 -expand href)"
    $url64   = "https://github.com$($download_page.links | ? href -match $re | select -Skip 1 -First 1 -expand href)"

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