$operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem
$lastBootUpTime = $operatingSystem.LastBootUpTime
$uptime = (Get-Date) - $lastBootUpTime
Write-Host "Tempo de funcionamento da CPU: $uptime"
