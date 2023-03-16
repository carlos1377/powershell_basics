<#
| - Passa a saída para o comando subsequente
> - Redireciona a saída pro arquivo especificado, se já existe, será substituido
>> - Redireciona a saída pro arquivo especificado, se já existe, será anexado
2> - Redireciona o erro pro arquivo especificado, se já existe, será substituido
2>> - Redireciona o erro pro arquivo especificado, se já existe, será anexado
#>
Set-Location C:\
Get-Process | ConvertTo-html | Out-File "processos html" 
Start-Process C:\

#gerar a data no txt, e depois vai ser substituido pelo dir
Get-Date > Lista.txt
Get-Content C:\
Get-ChildItem c:\ > .\Lista.txt

#gera a data no txt e ANEXA o dir no txt
Get-Date > Lista.txt
Get-ChildItem c:\ >> .\Lista.txt
notepad .\Lista.txt

Update-help 2> erro.log #transfere o erro 
Upddate-help 2>> erro.log #anexa ao inves de sobreescrever

Get-Process | Out-GridView

<#
Out-Default - Envia a saída padrão
Out-File - envia a saída para um arquivo
Out-GridView - envia a saída pra uma janela interativa separada
Out-Host - Envia a saída pra linha de comando
Out-Null - apaga a saída
Out-Printer - envia a saída pra uma impressora
Out-String - envia a saída para uma serie de strings
#>