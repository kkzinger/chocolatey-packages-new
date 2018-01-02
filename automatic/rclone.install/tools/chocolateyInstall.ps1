$ErrorActionPreference = 'Stop'

$installPath = "$env:ProgramFiles\rclone"

$packageArgs = @{
  packageName    = 'rclone.install'
  url            = 'https://github.com/ncw/rclone/releases/download/v1.39/rclone-v1.39-windows-386.zip'
  url64Bit       = 'https://github.com/ncw/rclone/releases/download/v1.39/rclone-v1.39-windows-amd64.zip'
  checksum       = '7bc33e1d3a79dada96582c123a8ff7ed834d99f04fbc6cc294f1646f883bcfb1'
  checksum64     = 'ccff7549455b07e95049afb778daf8fa9c83ade11fa780f65ef8e7c20bc1fbdc'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $installPath
}

Install-ChocolateyZipPackage @packageArgs

$zipPath = (get-item "$installPath/rclone*").Name
$finalPath = "$installPath/$zipPath"

Install-ChocolateyPath -PathToInstall $finalPath
