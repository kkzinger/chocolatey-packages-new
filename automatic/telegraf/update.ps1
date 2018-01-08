import-module au

$releases = 'https://portal.influxdata.com/downloads'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^[$]softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
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
    $download_page = Invoke-WebRequest -Uri $releases 

    $url = (($download_page.AllElements | Where Class -eq 'modal-body' | select -First 1 -ExpandProperty innerText) -split '["\n\r"|"\r\n"|\n|\r| ]' | Select-String -Pattern '\.zip$' | select -first 1).ToString()

    $version  = $url -split '[_-]|.zip' | select -Last 1 -Skip 3

    @{
        Version      = $version
        URL64        = $url
        ReleaseNotes = ''
    }
}

try {
    update -ChecksumFor none
} catch {
    $ignore = 'Unable to connect to the remote server'
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
