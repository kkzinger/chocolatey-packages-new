import-module au

$github_releases = 'https://github.com/ncw/rclone/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
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

update -ChecksumFor all
