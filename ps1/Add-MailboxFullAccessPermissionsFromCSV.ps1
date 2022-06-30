# Author: Andreas Hähnel
# provide a CSV that contains any columns and a colum named 'User' that conains the Exchange identifier of the delegates
# $mbx is the mailbox all the users will be added to

param(
    [Parameter(Mandatory=$true)][String]$csv,
    [Parameter(Mandatory=$true)][String]$mbx
)

if(-not (Get-Mailbox $mbx -ea silentlycontinue)) {Write-Host "Mailbox not found!" -ForegroundColor Red; exit}
if(-not (Test-Path $csv)){Write-Host "CSV not found!" -ForegroundColor Red; exit}
$c = Import-Csv $csv -Delimiter ";"


foreach ($u in $c)
{
    $m = Get-Mailbox $u.User -ea silentlycontinue
    if(-not $m) {continue}

    Write-Output $u.User
    Add-MailboxPermission -Identity $mbx -User $m.Alias -AccessRights FullAccess -InheritanceType All -AutoMapping $true
}
