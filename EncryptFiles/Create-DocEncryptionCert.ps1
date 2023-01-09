<#
    THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, 
    INCLUDING BUT NOT LIMITED To THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
    PARTICULAR PURPOSE.'

    IN NO EVENT SHALL MICROSOFT AND/OR ITS RESPECTIVE SUPPLIERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR 
    CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
    WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION 
    WITH THE USE OR PERFORMANCE OF THIS CODE OR INFORMATION.
#>
Add-Type -AssemblyName System.Windows.Forms

#Generate name prefix to use for certificate and certificate file name
$namePrefix = "WASA-$(get-date -UFormat %m%d%Y)"


#Region select output folder for private key file

Write-Host "Select folder to save public key" -ForegroundColor DarkGray
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "Select folder to save public key for certificate $($namePrefix)"
switch ((get-host).Version.Major) {
    "5" {
        $folderBrowser.RootFolder = 'MyComputer'
      }
    Default {
        $folderBrowser.UseDescriptionForTitle = $true

    }
} 
#endregion 


$folderBrowser.ShowDialog() | Out-Null
$folderPath = $folderBrowser.SelectedPath
Write-Host "Public key will saved in folder:" -ForegroundColor DarkGreen
Write-Host "$($folderPath)" -ForegroundColor DarkMagenta

$certData = New-SelfSignedCertificate -DNSname $namePrefix -CertStoreLocation 'Cert:\CurrentUser\My\' -KeyUsage KeyEncipherment, DataEncipherment, KeyAgreement -Type DocumentEncryptionCert -NotAfter (Get-Date).AddDays(4)

Write-Host "Created certificate $($certData.Subject)" -ForegroundColor DarkGreen

$publicCertData = Export-Certificate -Cert $certData -Type CERT -FilePath "$($folderPath)\public-$($namePrefix).cer"

Write-Host "Saved public certificate to $($folderPath)\public-$($namePrefix).cer" -ForegroundColor DarkGreen