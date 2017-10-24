
$ErrorActionPreference = 'Stop';

$packageName= 'gifsicle'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.88-win32.zip'
$url64      = 'https://eternallybored.org/misc/gifsicle/releases/gifsicle-1.88-win64.zip'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  Url           = $url
  Url64Bit      = $url64

  softwareName  = 'gifsicle*'

  Checksum      = '1C966E6213738F1374EEF0D1292DFECDCA25B080C958E4B596F0D0F2FD4C9198'
  ChecksumType  = 'sha256'
  Checksum64    = 'ADC2E4E7677122660D522E3241058E78A3441ECEA04656914E24893281E937B7'
  ChecksumType64= 'sha256'

}

Install-ChocolateyZipPackage @packageArgs


















