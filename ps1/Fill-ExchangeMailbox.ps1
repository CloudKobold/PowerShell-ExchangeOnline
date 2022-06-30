# Author: Andreas Hähnel
# sends emails from a specified folder to a certain size. Use that script to quickly generate some mailbox content
# the attached files are randomly picked from the specified folder

[CmdletBinding()]
param( 
 [Parameter(Mandatory=$true)][String]$Recipient, 
 [Parameter(Mandatory=$true)][Int32]$SizeInMB, 
 [Parameter(Mandatory=$true)][String]$FilesFolder, 
 [Parameter(Mandatory=$true)][String]$O365Sender
)
$ErrorActionPreference = 'SilentlyContinue'

[Double]$totalsize = 0
[Double]$attsize = 0
$pw = Read-Host ("Please enter the password for " + $O365Sender) -AsSecureString | ConvertFrom-Securestring
$creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $O365Sender, ($pw | ConvertTo-SecureString)
#$files = Get-ChildItem -Path $FilesFolder -Exclude "*.mp4" -Recurse
$files = Get-ChildItem -Path $FilesFolder -include "*.pptx" -Recurse
$mailcount = 1
while ($totalsize -lt $SizeInMB)
{ 
 $attachment = $files[(Get-Random -Minimum 0 -Maximum ($files.Count - 1))].FullName 
 $attsize = ((Get-Item $attachment).Length / 1000000) 
 $totalsize += $attsize 
 Write-Host ("Sending mail number " + $mailcount.ToString() + "; total size: " + $totalsize.ToString()) 
 Send-MailMessage -From $O365Sender -to $Recipient -Attachments $attachment -SmtpServer smtp.office365.com -Credential $creds -UseSsl -Subject ("Mail number " + $mailcount.ToString() + " via PowerShell script") -port 587 -body "<br><h1>Hallo</h1><br><br>Dies ist eine automatische Mail<br><br>Regards,<br>Your PowerShell Bot" -BodyAsHtml  
 $mailcount++
}
Write-Output "$mailcount Emails sent!"