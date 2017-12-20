$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$desktopPath = [Environment]::GetFolderPath("Desktop")
$lnkPath = $desktopPath + "\WindowsSpyBlocker.lnk"
$exePath = Join-Path $toolsPath "WindowsSpyBlocker.exe"

Install-ChocolateyShortcut -shortcutFilePath $lnkPath -targetPath $exePath

