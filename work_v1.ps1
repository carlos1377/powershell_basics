Add-Type -AssemblyName PresentationCore,PresentationFramework, System.Windows.Forms

$cred = Get-Credential -Message "Credentials are required for admin changes."

Set-executionPolicy -ExecutionPolicy 'Unrestricted'

$form = New-Object System.Windows.Forms.Form
$form.Text = "Config"
$form.Size = New-Object System.Drawing.Size(300, 200)
$form.ClientSize = New-Object System.Drawing.Size(325, 300)

$checkbox1 = New-Object System.Windows.Forms.CheckBox
$checkbox1.Text = "Programas"
$checkbox1.Location = New-Object System.Drawing.Point(20, 20)
$form.Controls.Add($checkbox1)

$checkbox2 = New-Object System.Windows.Forms.CheckBox
$checkbox2.Text = "Bit"
$checkbox2.Location = New-Object System.Drawing.Point(20, 60)
$form.Controls.Add($checkbox2)

$checkbox3 = New-Object System.Windows.Forms.CheckBox
$checkbox3.Text = "Wallpaper"
$checkbox3.Location = New-Object System.Drawing.Point(20, 100)
$form.Controls.Add($checkbox3)

$checkbox4 = New-Object System.Windows.Forms.CheckBox
$checkbox4.Text = "Registros" 
$checkbox4.Location = New-Object System.Drawing.Point(20, 140)
$form.Controls.add($checkbox4)

$checkbox5 = New-Object System.Windows.Forms.CheckBox
$checkbox5.Text = "Scripts Maquina" 
$checkbox5.Location = New-Object System.Drawing.Point(20, 180)
$form.Controls.add($checkbox5)

$checkbox6 = New-Object System.Windows.Forms.CheckBox
$checkbox6.Text = "Scripts Locais" 
$checkbox6.Location = New-Object System.Drawing.Point(20, 220)
$form.Controls.add($checkbox6)

$form.ShowDialog()

if ($checkbox1.Checked) {
    $programs =@(
        @('"\\micro39\Suporte\7ZIP\7z2201-x64.exe"', "7zip"),
        @('"\\micro39\Suporte\Acrobat Reader\AcroRdrDCx64_2200120117_MUI.exe"', "Adobe Acrobat"),
        @('"\\micro39\Suporte\K-Lite Mega Codec Pack\K-Lite_Codec_Pack_1750_Mega.exe"', "K-Lite"),
        @('"\\micro39\Suporte\Spark\spark_3_0_1-with-jre.exe"', "Spark"),
        @('"\\micro39\Suporte\UltraVNC\UltraVnc_1381\UltraVNC_1_3_81_X64_Setup.exe"', "UltraVnC")
        )
        
        foreach($program in $programs){
            $exe = $program[1]
            $msgBoxInput =  [System.Windows.MessageBox]::Show("Would you like to install $exe ?",'Install','YesNoCancel','Question')
            switch ($msgBoxInput) {
                'Yes' { 
                    Start-Process $program[0]
                    Start-Sleep 10
                }
                'No' {
                    break
                }
                'Cancel'{
                    exit
                }
            }
            
        }
    }
if ($checkbox2.Checked) {
    $msgBoxInput = [System.Windows.MessageBox]::Show("Would you like to Unzip BitDefender?",'Unzip','YesNo','Question')
    if ($msgBoxInput -eq 'Yes') { 
            Expand-Archive "\\micro39\Suporte\Bit\epskit_x64_7.8.1.244.zip" -DestinationPath C:\Users\ti.suporte\Desktop\
          }
    else{
            break
        }
    
    }
if ($checkbox3.Checked) {
    $msgBoxInput = [System.Windows.MessageBox]::Show("Would you like to Apply the wallpaper?",'Wallpaper','YesNo','Question')
    if ($msgBoxInput -eq 'Yes') { 
            Copy-Item "\\micro39\Suporte\Papel Parede Multimoveis\papel_parede.jpg" -Destination C:\Windows\Web\Wallpaper\ -Credential $cred
          }
    else{
            break
        }
    
    }
if ($checkbox4.Checked) {
    $regs = @(
        @("\\micro39\Suporte\Registros\ConsentPromptBehaviorAdmin.reg", "ConsentPromptBehaviorAdmin"),
        @("\\micro39\Suporte\Registros\Organização.reg", "Organização")
    )
    foreach($reg in $regs){
        $exe = $reg[1]
        $msgBoxInput =  [System.Windows.MessageBox]::Show("Would you like to update the $exe registry?",'Install','YesNoCancel','Question')
        switch ($msgBoxInput) {
            'Yes' { 
                Start-Process $reg[0]
                Start-Sleep 10
    
            }
            'No' {
                break
            }
            'Cancel'{
                exit
            }
        }
        
    }
    }
if ($checkbox5.Checked) {
    $pss = @(
        @('"\\micro39\Suporte\Scripts\ICMPv4.ps1"', "ICMPv4"),
        @('"\\micro39\Suporte\Scripts\Onedrive_remove.ps1"', "Onedrive_Remove"),
        @('"\\micro39\Suporte\Scripts\WinRM.ps1"',"WinRM")
    )
    foreach($ps in $pss){
        $exe = $ps[1]
        $msgBoxInput =  [System.Windows.MessageBox]::Show("Would you like to execute the $exe script?",'execution','YesNoCancel','Question')
        switch ($msgBoxInput) {
            'Yes' { 
                Start-Process powershell_ise -verb runas $ps[0]
                Start-Sleep 5
            }
            'No' {
                break
            }
            'Cancel'{
                exit
            }
        }

    }

    }
if ($checkbox6.Checked) {
    $psimp = @(
        @('"\\micro39\Suporte\Scripts\Instala Drivers Laser.vbs"', "Instala Imp"),
        @('"\\micro39\Suporte\Scripts\Remove impressoras local.ps1"', "Remove Imp")
    )
        $exe = $psimp[0][1]
        $msgBoxInput =  [System.Windows.MessageBox]::Show("Would you like to execute the $exe script?",'execution','YesNoCancel','Question')
        switch ($msgBoxInput) {
            'Yes' { 
                Start-Process $psimp[0][0] 
                Start-Sleep 5
            }
            'No' {
                break
            }
            'Cancel'{
                exit
            }
        }

    $exe = $psimp[1][1]
    $msgBoxInput =  [System.Windows.MessageBox]::Show("Would you like to execute the $exe script?",'execution','YesNoCancel','Question')
    switch ($msgBoxInput) {
        'Yes' { 
            Start-Process powershell_ise -verb runas $psimp[1][0]  # Start-Process powershell_ise.exe -verb runas '"\\micro39\Suporte\Scripts\ICMPv4.ps1"'
            Start-Sleep 5
        }
        'No' {
            break
        }
        'Cancel'{
            exit
        }
    }

$form1 = New-Object System.Windows.Forms.Form
$form1.Text = "Escolha sua versão de Windows"
$form1.Size = New-Object System.Drawing.Size(300, 150)
$form1.ClientSize = New-Object System.Drawing.Size(325, 175)

$script:selectedOption = $null

$buttonOption1 = New-Object System.Windows.Forms.Button
$buttonOption1.Text = "Windows 11"
$buttonOption1.Location = New-Object System.Drawing.Point(20, 20)
$buttonOption1.Add_Click({
    $script:selectedOption = 1
    $form1.Close()
})
$form1.Controls.Add($buttonOption1)

$buttonOption2 = New-Object System.Windows.Forms.Button
$buttonOption2.Text = "Windows 10"
$buttonOption2.Location = New-Object System.Drawing.Point(20, 60)
$buttonOption2.Add_Click({
    $script:selectedOption = 2
    $form1.Close()
})
$form1.Controls.Add($buttonOption2)

$buttonOption3 = New-Object System.Windows.Forms.Button
$buttonOption3.Text = "Windows 8"
$buttonOption3.Location = New-Object System.Drawing.Point(20, 100)
$buttonOption3.Add_Click({
    $script:selectedOption = 3
    $form1.Close()
})

$form1.Controls.Add($buttonOption3)

$form1.ShowDialog()

    switch ($script:selectedOption) {
        1 {
            Start-Process "\\micro39\Suporte\Scripts\Remove_App_Win11_usuarios.ps1" 

        }
        2 {
            Start-Process "\\micro39\Suporte\Scripts\Remove_App_Win10_v6.ps1"

        }
        3 {
            Start-Process "\\micro39\Suporte\Scripts\Remove_App_Win8_v2.ps1"

        }
        default {
            Write-Host "Nenhuma opção selecionada"
        }
    }
}
