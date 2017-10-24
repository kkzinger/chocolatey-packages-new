
$ErrorActionPreference = 'Stop';


$packageName= 'collectdwin'
$url        = 'https://github.com/bloomberg/collectdwin/releases/download/v0.5.19/CollectdWin-x64-0.5.19.0.msi'
$url64      = 'https://github.com/bloomberg/collectdwin/releases/download/v0.5.19/CollectdWin-x64-0.5.19.0.msi'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'msi'
  url           = $url
  url64bit      = $url64

  silentArgs    = '/qn /norestart'
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'collectdwin*'
  checksum      = 'FDAA0A3F59B44FC98E194F741D7E4DAB4760EC23615218959C9701D76BC73B5E'
  checksumType  = 'sha256'
  checksum64    = 'FDAA0A3F59B44FC98E194F741D7E4DAB4760EC23615218959C9701D76BC73B5E'
  checksumType64= 'sha256'
}

Install-ChocolateyPackage @packageArgs

















