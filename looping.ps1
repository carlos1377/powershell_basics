# exemplo for

For($var=1; $var -le 255; $var++){
    Write-Host 192.168.0.$var
}


#foreach

foreach ($numeros in 1,2,3,4,5,6,7,8){
    Write-Host $numeros
}

foreach($arquivos in Get-ChildItem){
    if($arquivos.IsReadOnly){
        Write-Host $arquivos.FullName
    }
}

GEt-Process Notepad 
Get-Process Notepad | ForEach-Object kill

#while

$i = 0
while ($true) {
    $i++
    Write-Host contando $i
    if($i -ge 1000)
        {break}
    
}
