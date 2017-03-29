
$installFolder = Join-Path $env:ProgramFiles 'rclone'

Remove-Item -Path $installFolder -Recurse -Confirm:$false -Force
