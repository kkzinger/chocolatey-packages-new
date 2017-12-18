import-module au

$releases = 'https://github.com/d2phap/ImageGlass/releases'

function global:au_SearchReplace {
   @{
        ".\tools\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}
function global:au_BeforeUpdate {

    Get-RemoteFiles -Purge 
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    
    $re = '.+\.exe$'
    $url   = "https://github.com$($download_page.links | ? href -match $re | select -First 1 -expand href)"


    $version  = $url -split '/' | select -Last 1 -Skip 1

    @{
        Version      = $version
        URL64        = $url
    }
}

try {
    update -ChecksumFor none
} catch {
    $ignore = 'Unable to connect to the remote server'
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}