$EnabledUsers = Import-CSV bookingsusers.csv
$DisabledUsers = Import-CSV NonBookingsusers.csv
foreach($user in $EnabledUsers) {
    if($null -eq (Get-CASMailbox -Identity $user | select EwsApplicationAccessPolicy).EwsApplicationAccessPolicy ) 
    {
        #nothing to do, personal Bookings is available for everyone 
    }

    if((Get-CASMailbox -Identity $user | select EwsApplicationAccessPolicy).EwsApplicationAccessPolicy -eq "EnforceAllowList" )
    {
        Set-CASMailbox -Identity $user -EwsEnabled $true
        Set-CASMailbox -Identity $user -EwsAllowList @{Add="MicrosoftOWSPersonalBookings"}
    }

    if((Get-CASMailbox -Identity $user | select EwsApplicationAccessPolicy).EwsApplicationAccessPolicy -eq "EnforceBlockList" )
    {
        Set-CASMailbox -Identity $user -EwsEnabled $true
        Set-CASMailbox -Identity $user -EwsBlockList @{Remove="MicrosoftOWSPersonalBookings"}
    }

}

foreach($user in $DisabledUsers) {
    if($null -eq (Get-CASMailbox -Identity $user | select EwsApplicationAccessPolicy).EwsApplicationAccessPolicy )
    {
        Set-CASMailbox -Identity $user -EwsApplicationAccessPolicy EnforceBlockList -EWSBlockList @{Add="MicrosoftOWSPersonalBookings"}
    }

    if((Get-CASMailbox -Identity $user | select EwsApplicationAccessPolicy).EwsApplicationAccessPolicy -eq "EnforceAllowList" )
    {
        Set-CASMailbox -Identity $user -EwsAllowList @{Remove="MicrosoftOWSPersonalBookings"}
    }

    if((Get-CASMailbox -Identity $user | select EwsApplicationAccessPolicy).EwsApplicationAccessPolicy -eq "EnforceBlockList" )
    {
        Set-CASMailbox -Identity $user -EwsBlockList @{Add="MicrosoftOWSPersonalBookings"}
    }
}