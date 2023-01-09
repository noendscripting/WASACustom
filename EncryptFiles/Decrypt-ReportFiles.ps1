<#
    THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, 
    INCLUDING BUT NOT LIMITED To THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
    PARTICULAR PURPOSE.'

    IN NO EVENT SHALL MICROSOFT AND/OR ITS RESPECTIVE SUPPLIERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR 
    CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
    WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION 
    WITH THE USE OR PERFORMANCE OF THIS CODE OR INFORMATION.
#>


param(
[Parameter(Mandatory=$true)]
[string]$certName,
[Parameter(Mandatory=$true)]
[ValidateScript({Test-Path -Path $_})]
[string]
$pathToEncryptedFiles
)

$ErrorActionPreference = 'Stop'

if ($pathToEncryptedFiles -match '^(?!.*\\$).*$' )
{

    $fileDirectory = "$($pathToEncryptedFiles)\*.csv"
}
else {
    $fileDirectory = "$($pathToEncryptedFiles)*.csv"
}

$fileList = Get-ChildItem -Path $fileDirectory 



foreach ($filePath in $fileList )
{
    $outFilePath = ($filePath.FullName).Replace('protected','decrypted')

    try {

        $output = Unprotect-CmsMessage -Path $filePath.FullName -to $certName -Verbose -ErrorAction Stop 

    }
    Catch {
        Write-Host $Error[0] -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor red
        exit

    }
    $output| Out-File $outFilePath

     Write-Host "Saved decrypted file $($outFilePath)" -ForegroundColor DarkGreen


   
}


