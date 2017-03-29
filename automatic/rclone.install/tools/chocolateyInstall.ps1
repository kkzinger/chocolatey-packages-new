$ErrorActionPreference = 'Stop'

$installPath = "$env:ProgramFiles\rclone"

$packageArgs = @{
  packageName    = 'rclone.install'
  url            = 'http://downloads.rclone.org/rclone-current-windows-386.zip'
  url64Bit       = 'http://downloads.rclone.org/rclone-current-windows-amd64.zip'
  checksum       = '08ec38b8b5e332494d44ee9b0acfd64a39ec778f37750e4a81bb4d12eb3b66a8'
  checksum64     = '10abb1d25f0e3eb6e98f8894c6e5ecd20d22aeee7bbade84e9e4e816491a3330'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $installPath
}

Install-ChocolateyZipPackage @packageArgs

$zipPath = (get-item "$installPath/rclone*").Name
$finalPath = "$installPath/$zipPath"

Install-ChocolateyPath -PathToInstall $finalPath
