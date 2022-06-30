# Author: Andreas Hähnel
# if you switch from FullAccess via group to direct, that scripts helps you

param(
    [Parameter(Mandatory=$true)][String]$MBX,
    [Parameter(Mandatory=$true)][String]$group
)

function Resolve-Group
{
    param(
        [Parameter(Mandatory=$true)][String]$subgroup
    )
    $sList = @()
    $sg = Get-DistributionGroup $subgroup
    if(!$sg){Write-Host "ERROR: $sg not found" -ForegroundColor red}
    $sm = Get-DistributionGroupMember $sg.Identity
    if(!$sm){Write-Host "ERROR: Could not read membership of $sg " -ForegroundColor red}
    foreach($s in $sm)
    {
        if($s.RecipientType -eq "UserMailbox") {$sList += $s.PrimarySmtpAddress}
        elseif ($s.RecipientType -eq "MailUniversalSecurityGroup") 
        { $sList += Resolve-Group -subgroup $s.Identity}
    }
    return $sList
}

$mList = @()
$m = Get-Mailbox $MBX
if(!$m){Write-Host "ERROR: mailbox $MBX not found" -ForegroundColor red;exit}
$g = Get-DistributionGroup $group
if(!$g){Write-Host "ERROR: Group $group not found!" -ForegroundColor red;exit}

$mList = Resolve-Group -subgroup $g.Identity
$mList = $mList | select -Unique

$mList | %{Add-MailboxPermission -Identity $m.Alias -User $_ -AccessRights FullAccess -InheritanceType All -AutoMapping $true}