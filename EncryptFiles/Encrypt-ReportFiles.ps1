<#
    THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, 
    INCLUDING BUT NOT LIMITED To THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
    PARTICULAR PURPOSE.'

    IN NO EVENT SHALL MICROSOFT AND/OR ITS RESPECTIVE SUPPLIERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR 
    CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
    WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION 
    WITH THE USE OR PERFORMANCE OF THIS CODE OR INFORMATION.
#>



$ErrorActionPreference = 'Stop'
Function Select-Folder($description)
{
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = $description
switch ((get-host).Version.Major) {
    "5" {
        $folderBrowser.RootFolder = 'MyComputer'
      }
    Default {
        $folderBrowser.UseDescriptionForTitle = $true

    }
}
$folderBrowser.ShowDialog() | Out-Null

return  $folderBrowser.SelectedPath
}

#$certName = Read-Host -Prompt "Type name of the certificate"

Write-Host "Select folder where report files are located" -ForegroundColor DarkGray

$sourceFilesPath = Select-Folder -description "Select folder where report files are located"

Write-Host "Select output folder for encrypted files" -ForegroundColor DarkGray

$destinationFolder = Select-Folder -description "Select output folder for encrypted files"

Write-Host "Select path to the public certficate" -ForegroundColor DarkGray

$fileBrowser = New-Object System.Windows.Forms.OpenFileDialog
$fileBrowser.Filter = "Certificate files (*.cer)|*.cer"
$fileBrowser.Title = "Select path to the public certficate"
$fileBrowser.ShowDialog() | Out-Null

$publicCertificatePath = $fileBrowser.FileName



$csvFiles = Get-ChildItem -Path $sourceFilesPath -Filter "*.csv"



foreach ($csvFile in $csvFiles )
{

    try {

        Protect-CmsMessage -Path $_.FullName -OutFile "$($destinationFolder)\protected-$($csvFile.name)" -To $publicCertificatePath -ErrorAction Stop

    }
    Catch {
        Write-Host $Error[0] -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor red

    }

     if (Test-Path "$($destinationFolder)\protected-$($_.name)" )
     {
        Write-Host "Created encrypted file $($destinationFolder)\protected-$($csvFile.name) " -ForegroundColor DarkGray
     }
     else {
        Write-Host "Failed to create file terminating script" -ForegroundColor Red
        Exit
     }


   
}


