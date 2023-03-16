Set-Location "C:\Users\$env:username\Desktop"

$perm = Get-ExecutionPolicy

if ($perm -ne 'Unrestricted') {
    Set-ExecutionPolicy Unrestricted
    }

function getConvert {

Param (
    [Parameter(
        Mandatory = $true,
        Position = 1,
        ValueFromPipeline = $true,
        ValueFromPipelineByPropertyName = $true,
        ValueFromRemainingArguments = $true,
        HelpMessage = "Array of image file names to convert to JPEG")]
    [Alias("FullName")]
    [String[]]
    $Files,

    [Parameter(
        HelpMessage = "Fix extension of JPEG files without the .jpg extension")]
    [Switch]
    $FixExtensionIfJpeg
)

Begin
{
    # Technique for await-ing WinRT APIs: https://fleexlab.blogspot.com/2018/02/using-winrts-iasyncoperation-in.html
    Add-Type -AssemblyName System.Runtime.WindowsRuntime
    $runtimeMethods = [System.WindowsRuntimeSystemExtensions].GetMethods()
    $asTaskGeneric = ($runtimeMethods | Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]
    Function AwaitOperation ($WinRtTask, $ResultType)
    {
        $asTaskSpecific = $asTaskGeneric.MakeGenericMethod($ResultType)
        $netTask = $asTaskSpecific.Invoke($null, @($WinRtTask))
        $netTask.Wait() | Out-Null
        $netTask.Result
    }
    $asTask = ($runtimeMethods | Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncAction' })[0]
    Function AwaitAction ($WinRtTask)
    {
        $netTask = $asTask.Invoke($null, @($WinRtTask))
        $netTask.Wait() | Out-Null
    }

    # Reference WinRT assemblies
    [Windows.Storage.StorageFile, Windows.Storage, ContentType=WindowsRuntime] | Out-Null
    [Windows.Graphics.Imaging.BitmapDecoder, Windows.Graphics, ContentType=WindowsRuntime] | Out-Null
}

Process
{
    # Summary of imaging APIs: https://docs.microsoft.com/en-us/windows/uwp/audio-video-camera/imaging
    foreach ($file in $Files)
    {
        Write-Host $file -NoNewline
        try
        {
            try
            {
                # Get SoftwareBitmap from input file
                $file = Resolve-Path -LiteralPath $file
                $inputFile = AwaitOperation ([Windows.Storage.StorageFile]::GetFileFromPathAsync($file)) ([Windows.Storage.StorageFile])
                $inputFolder = AwaitOperation ($inputFile.GetParentAsync()) ([Windows.Storage.StorageFolder])
                $inputStream = AwaitOperation ($inputFile.OpenReadAsync()) ([Windows.Storage.Streams.IRandomAccessStreamWithContentType])
                $decoder = AwaitOperation ([Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($inputStream)) ([Windows.Graphics.Imaging.BitmapDecoder])
            }
            catch
            {
                # Ignore non-image files
                Write-Host " [Unsupported]"
                continue
            }
            if ($decoder.DecoderInformation.CodecId -eq [Windows.Graphics.Imaging.BitmapDecoder]::JpegDecoderId)
            {
                $extension = $inputFile.FileType
                if ($FixExtensionIfJpeg -and ($extension -ne ".jpg") -and ($extension -ne ".jpeg"))
                {
                    # Rename JPEG-encoded files to have ".jpg" extension
                    $newName = $inputFile.Name -replace ($extension + "$"), ".jpg"
                    AwaitAction ($inputFile.RenameAsync($newName))
                    Write-Host " => $newName"
                }
                else
                {
                    # Skip JPEG-encoded files
                    Write-Host " [Already JPEG]"
                }
                continue
            }
            $bitmap = AwaitOperation ($decoder.GetSoftwareBitmapAsync()) ([Windows.Graphics.Imaging.SoftwareBitmap])

            # Write SoftwareBitmap to output file
            $outputFileName = $inputFile.DisplayName + ".jpg";
            $outputFile = AwaitOperation ($inputFolder.CreateFileAsync($outputFileName, [Windows.Storage.CreationCollisionOption]::ReplaceExisting)) ([Windows.Storage.StorageFile])
            $outputStream = AwaitOperation ($outputFile.OpenAsync([Windows.Storage.FileAccessMode]::ReadWrite)) ([Windows.Storage.Streams.IRandomAccessStream])
            $encoder = AwaitOperation ([Windows.Graphics.Imaging.BitmapEncoder]::CreateAsync([Windows.Graphics.Imaging.BitmapEncoder]::JpegEncoderId, $outputStream)) ([Windows.Graphics.Imaging.BitmapEncoder])
            $encoder.SetSoftwareBitmap($bitmap)
            $encoder.IsThumbnailGenerated = $true

            # Do it
            AwaitAction ($encoder.FlushAsync())
            Write-Host " -> $outputFileName"
        }
        catch
        {
            # Report full details
            throw $_.Exception.ToString()
        }
        finally
        {
            # Clean-up
            if ($null -ne $inputStream) { [System.IDisposable]$inputStream.Dispose() }
            if ($null -ne $outputStrea) { [System.IDisposable]$outputStream.Dispose() }
            Out-Null 
            
            

        }

        
    }
   }

}

Write-host "`nSelecione o arquivo de imagem.`n" -ForegroundColor Yellow
Add-Type -AssemblyName System.Windows.Forms
$DefaultPatch = "C:\Users\$env:username\Desktop" 
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
    InitialDirectory = $DefaultPatch
    MultiSelect = $true
}
$null = $FileBrowser.ShowDialog()

$item = @()

foreach($arq in $FileBrowser.FileNames){
 getConvert $arq -FixExtensionIfJpeg | Out-null
 $item +=$arq 
} 

$allProcesses = Get-Process
foreach($lockedFile in $item) {
foreach ($process in $allProcesses) { 
$process.Modules | Where-Object {$_.FileName -eq $lockedFile} | Stop-Process -Force -ErrorAction SilentlyContinue
    }
}
Write-Host "`nApagando Imagens...`n" -ForegroundColor Yellow

Remove-Item -Path $item -Force -Recurse -Confirm
 
Write-Host "`nImagens convertidas e renomeadas!`n" -ForegroundColor Yellow
