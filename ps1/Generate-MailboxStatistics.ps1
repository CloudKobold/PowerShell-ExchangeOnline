# Author: Andreas Hähnel
# generate quick-and-dirty mailbox statistics for the whole organization

$(Foreach ($mailbox in Get-Mailbox -ResultSize Unlimited)
{$Stat = $mailbox | Get-MailboxStatistics | Select TotalItemSize,ItemCount
	New-Object PSObject -Property @{
	FirstName = $mailbox.FirstName
	LastName = $mailbox.LastName
	DisplayName = $mailbox.DisplayName
	TotalItemSize = $Stat.TotalItemSize
	ItemCount = $Stat.ItemCount
	PrimarySmtpAddress = $mailbox.PrimarySmtpAddress
	Alias = $mailbox.Alias
	}
}) | Select FirstName,LastName,DisplayName,TotalItemSize,ItemCount,PrimarySmtpAddress,Alias | Export-CSV "C:\temp\MailboxReport.csv" -NTI
