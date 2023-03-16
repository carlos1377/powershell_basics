#worflow

workflow hello
{
    Write-Output "hello world"
}

function start_editor{
Start-Process notepad
Start-Sleep 5 
Start-Process wordpad
}

workflow iniciar_editor{
Parallel{
    Start-Process notepad
    Start-Sleep -seconds 5
    Start-Process wordpad
    }
}
