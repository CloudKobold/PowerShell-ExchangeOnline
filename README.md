# PowerShell-ExchangeOnline
This repository contains scripts and little helpers in the daily work or migration. These scripts are not always in 'prettiest' PowerShell language, but they are more intended to be little helpers and problem solvers.

## Add-MailboxFullAccessPermissionsFromCSV.ps1
Use this if you have 1 target mailbox (e.g. Shared Mailbox) and need to add a lot of people with FullAccess permissions. Provide the people with a CSV in the column 'User'. 
```powershell
.\Add-MailboxFullAccessPermissionsFromCSV.ps1 -CSV "C:\script\myUsers.csv" -mbx "mySharedMailbox@contoso.com"
```

## Fill-ExchangeMailbox.ps1
You need to let your mailbox grow for a certain amount of data within a short time? Specify a folder, the intended size, sender and recipient and let PowerShell send emails from your source mailbox to the recipient until the size is reached. Be careful not to blow up the recipients mailbox ;)
```powershell
.\Fill-ExchangeMailbox.ps1 -Recipient "target@contoso.com" -SizeInMB 50 -FilesFolder "C:\myStuff" -O365Sender "myMailbox@contoso.com"
```

## Generate-MailboxStatistics.ps1
This script reads mailbox sizes and item count for all mailboxes in your organization and exports this data to C:\temp\MailboxReport.csv

## Resolve-MailboxPermissionsAndSetAutomapping.ps1
Exchange Online can grant FullAccess permissions for groups, but this doesn't count for Automapping. So, if you have to switch to direct permissions, provide the targetmailbox and group name, the script will add all group members directly to FullAccess permissions
```powershell
.\Resolve-MailboxPermissionsAndSetAutomapping.ps1 -MBX 'targetmailbox@contoso.com' -group 'sales@contoso.com'
```

