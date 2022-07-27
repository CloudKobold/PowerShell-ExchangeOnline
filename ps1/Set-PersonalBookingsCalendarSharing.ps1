Connect-ExchangeOnline
$domains = Get-SharingPolicy -Identity "Default Sharing Policy" | select -expand Domains  
if ($domains -notcontains "Anonymous:CalendarSharingFreeBusyReviewer") 
{
    Set-SharingPolicy "Default Sharing Policy" -Domains @{Add="Anonymous:CalendarSharingFreeBusyReviewer"}
}  