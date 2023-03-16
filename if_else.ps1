#consultar um serviço do windows
$serv = Get-Service -Name spooler
if($serv.Status -eq "Running")
    {
    Write-Host Em execução
    }
    else{
    Write-Host Serviço Parado
    }