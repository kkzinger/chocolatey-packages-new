$ErrorActionPreference = 'Stop'

$installPath = "$env:ProgramFiles\rclone"

$packageArgs = @{
  packageName    = 'rclone.install'
  url            = 'http://downloads.rclone.org/rclone-current-windows-386.zip'
  url64Bit       = 'http://downloads.rclone.org/rclone-current-windows-amd64.zip'
  checksum       = '6a7fcbc575fe290a27a16eccdc8b1a954d31aaefec1dca3f98b478a1a3bf6db3'
  checksum64     = 'bdeae203497dae119da6cb41c14a484b971b353ab591627d7ac5e936db4912a6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $installPath
}

$zipPath = (get-item "$installPath/rclone*").Name
$finalPath = "$installPath/$zipPath"

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath -PathToInstall $finalPath
