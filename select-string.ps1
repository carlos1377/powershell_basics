$path = "C:\"

Get-Content $path\slctstring.txt | Select-String TESTE
Select-String -Pattern te $path\slctstring.txt
Get-ChildItem $path\*.txt | Select-String te

Select-String -Path "C:\slctstring.txt" -Pattern gorila -Context 1,1
Select-String -Path "C:\slctstring.txt" -Pattern gorila -NotMatch