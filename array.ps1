# Script Array
Clear-Host
$googleDNS = @("8.8.8.8", "8.8.4.4")
$TotalDNS = $googleDNS.Count

Write-Host "pingando todos os $TotalDNS DNS do Google"

Test-Connection $googleDNS -Count 1
Start-Sleep 3
Write-Host FIM!

