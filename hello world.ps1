Clear-Host
$nome = Read-Host "qual seu nome?"
$saudacao = "Olá"
$frase = "$saudacao, $nome"
Write-Host $frase

$frase.ToUpper()