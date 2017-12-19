import-module au

$releases = 'https://storage.googleapis.com/downloads.webmproject.org/releases/webp/index.html'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\tools\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -FileNameSkip 1
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re32    = 'libwebp-.+x86\.zip$'
    $url32   =  'https:'+($download_page.links | ? href -match $re32 | select -Last 1 -expand href)

    
    $re64    = 'libwebp-.+x64\.zip$'
    $url64   =  'https:'+($download_page.links | ? href -match $re64 | select -Last 1 -expand href)

    $version = ($url64 -split '/' | select -Last 1) -split '-' | select -First 1 -Skip 1

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