# REGEX LIBRARY - https://regexlib.com/CheatSheet.aspx
$email = Read-Host Qual seu email ?
$regex = "^[a-z]+\.[a-z]+@gmail.com$"



If ($email –notmatch $regex) {
  Write-Host "Errou o endereço de email  $email" 
  #Exit
  }

Write-Host Acertou !
 
 $CPF = @(
 "189.168.666-08"
 "18916866608"
 )

$CPF | Select-String -Pattern '\d.\d.\d-\d'

<#

\d = numérico [0-9]
\w = alpha numérico [a-zA-Z0-9]
\s = caractere de espaço em branco
. = qualquer caractere exceto nova linha
() = sub-expession
\ = Próximo caractere será valido (por exemplo \.)
#>