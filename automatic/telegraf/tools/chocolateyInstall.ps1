$ErrorActionPreference = 'Stop'

$unzip_folder = $env:ProgramFiles
$install_folder = "$unzip_folder\telegraf"
$packageName = 'telegraf'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$fileLocation = Join-Path $install_folder 'telegraf.exe'
$zip_path =  Get-Item "$toolsPath\*_x64.zip"
$softwareName = 'telegraf*'


If (Get-Service -Name "telegraf" -ErrorAction SilentlyContinue) {
    & $fileLocation --service uninstall
}

$packageArgs = @{
    PackageName  = $packageName
    FileFullPath = $zip_path
    Destination  = $unzip_folder
}
Get-ChocolateyUnzip @packageArgs
rm $zip_path -ea 0

If (Get-Service -Name "telegraf" -ErrorAction SilentlyContinue) {
    & $fileLocation --service uninstall
}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $unzip_folder
  fileType      = 'EXE'
  file         = $fileLocation
  softwareName  = $softwareName
  silentArgs    = "--service install"
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs
