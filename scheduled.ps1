#get-command -Module PSScheduledJob | Sort-Object Noun


#          TRIGGERS DO SCHEDULED JOB
#$diario = New-JobTrigger -Daily -At 4pm
#$semanal = New-JobTrigger -Weekly -At 4pm
#$unica = New-JobTrigger -Once -At (Get-Date).AddMinutes(10)
$quartas = New-JobTrigger -Weekly -DaysOfWeek Wednesday  -At 4pm

$source = #pasta para o backup ser realizado
$dest = #pasta de destino do backup

Register-ScheduledJob -Name Backup -Trigger $quartas -ScriptBlock{
    Compress-Archive -Path $source -DestinationPath $dest -Force
}

Get-ScheduledJob Backup | Get-JobTrigger


#Get-ScheduledJob Backup | Unregister-ScheduledJob #-> desabilita o backup
 
