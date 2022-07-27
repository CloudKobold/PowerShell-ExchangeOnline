if((Get-OrganizationConfig | select EwsEnabled).EwsEnabled -eq $false)
{  Set-OrganizationConfig -EwsEnabled $true }

## ENABLE personal Bookings globally
if((Get-OrganizationConfig | select EwsApplicationAccessPolicy).EwsApplicationAccessPolicy -eq "EnforceAllowList" )
{
    Set-OrganizationConfig -EwsAllowList @{Add="MicrosoftOWSPersonalBookings"}
}

if((Get-OrganizationConfig | select EwsApplicationAccessPolicy).EwsApplicationAccessPolicy -eq "EnforceBlockList" )
{
    Set-OrganizationConfig -EwsBlockList @{Remove="MicrosoftOWSPersonalBookings"}
}


## DISABLE personal Bookings globally
if($null -eq (Get-OrganizationConfig | select EwsApplicationAccessPolicy).EwsApplicationAccessPolicy )
{
    Set-OrganizationConfig -EwsApplicationAccessPolicy EnforceBlockList -EwsBlockList @{Add="MicrosoftOWSPersonalBookings"}
}

if((Get-OrganizationConfig | select EwsApplicationAccessPolicy).EwsApplicationAccessPolicy -eq "EnforceAllowList" )
{
    Set-OrganizationConfig -EwsAllowList @{Remove="MicrosoftOWSPersonalBookings"}
}

if((Get-OrganizationConfig | select EwsApplicationAccessPolicy).EwsApplicationAccessPolicy -eq "EnforceBlockList" )
{
    Set-OrganizationConfig -EwsBlockList @{Add="MicrosoftOWSPersonalBookings"}
}
