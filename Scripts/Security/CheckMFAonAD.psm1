Import-Module ActiveDirectory

Get-ADUser -Filter * -Properties * | Where-Object { $_.SmartcardLogonRequired -ne $true } | Select-Object Name, UserPrincipalName
