﻿$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$zip_path = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; Get-Item "$toolsPath\*_x64.zip"
} else { Write-Host "Installing 32 bit version"; Get-Item "$toolsPath\*_x32.zip" }

$packageArgs = @{
    PackageName  = 'webp'
    FileFullPath = $zip_path
    Destination  = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
rm $zip_path -ea 0
