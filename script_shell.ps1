#New-Object -ComObject WScript.Shell

$wshell = New-Object -ComObject WScript.Shell

# $wshell | Get-Member -> lista as possibilidades com o wshell

$wshell.Run("Notepad")
$wshell.AppActivate("Notepad")
Start-Sleep -Seconds 1
$wshell.SendKeys("alooo")




