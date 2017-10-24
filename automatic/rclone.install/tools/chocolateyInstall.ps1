$ErrorActionPreference = 'Stop'

$installPath = "$env:ProgramFiles\rclone"

$packageArgs = @{
  packageName    = 'rclone.install'
  url            = 'https://github.com/ncw/rclone/releases/download/v1.38/rclone-v1.38-windows-386.zip'
  url64Bit       = 'https://github.com/ncw/rclone/releases/download/v1.38/rclone-v1.38-windows-amd64.zip'
  checksum       = '243048b24b05fbc7efbf00ea6b66bca43c3d7e2a8600bc7585a6ef0cf877fe2c'
  checksum64     = '2be955fbce650a0b93e7c907f2b8c56a8af95bb5e341be3f90623d822abd083f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $installPath
}

Install-ChocolateyZipPackage @packageArgs

$zipPath = (get-item "$installPath/rclone*").Name
$finalPath = "$installPath/$zipPath"

Install-ChocolateyPath -PathToInstall $finalPath
