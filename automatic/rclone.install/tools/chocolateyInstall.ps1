$ErrorActionPreference = 'Stop'

$installPath = "$env:ProgramFiles\rclone"

$packageArgs = @{
  packageName    = 'rclone.install'
  url            = 'https://github.com/ncw/rclone/releases/download/v1.42/rclone-v1.42-windows-386.zip'
  url64Bit       = 'https://github.com/ncw/rclone/releases/download/v1.42/rclone-v1.42-windows-amd64.zip'
  checksum       = 'C87E3B833D70DDD60313C24A798BFB0A2142BC47005B4E93F46F7CC285B5C844'
  checksum64     = '0420E14DE580B3CA35E3ED102E23DDBD6EB5CB182CCC3311F9D7B5576C5C9AB0'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $installPath
}

Install-ChocolateyZipPackage @packageArgs

$zipPath = (get-item "$installPath/rclone*").Name
$finalPath = "$installPath/$zipPath"

Install-ChocolateyPath -PathToInstall $finalPath
