 <# 
 Where-Object{$_.Status -eq "Running"}
             {$_.Campo operador valor}
 
 -eq igual
 -lt menor que
 -le menor ou igual
 -gt maior que
 -ge maior ou igual
 -ne não igual
 -like usa wildcards
 
 #>

Get-Service | Where-Object {$_.Status -eq "Running"}
Get-Service | Where-Object {$_.DisplayName -like "*Security*"}
