<#
Get-Counter '\processador(_total)\% tempo de processador' `
| Select-Object -ExpandProperty countersamples `
| Select-Object -Property instancename, cookedvalue `
| Sort-Object -Property cookedvalue -Descending | Select-Object -First 20 `
| Format-Table InstanceName,@{L='CPU';E={($_.Cookedvalue/100).toString('P')}} -AutoSize
#>

$scriptBlock = 
{
$operatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem
$lastBootUpTime = $operatingSystem.LastBootUpTime
$uptime = (Get-Date) - $lastBootUpTime
Write-Host "Tempo de funcionamento da CPU: $uptime"
}

$computers = localhost

Invoke-command -ComputerName $computers -ScriptBlock $scriptBlock