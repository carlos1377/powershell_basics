# jobs = execução de comandos em background
# scheduled jobs = agendamento de trabalhos

Workflow demorado{
    while(1)
    {
        (get-date).ToString() + "script demoradinho"
        Start-Sleep -seconds 2
    }
}

$wfjob = demorado -Asjob
$wfjob

Receive-Job $wfjob
Suspend-Job $wfjob
Stop-Job $wfjob
Resume-Job $wfjob
 