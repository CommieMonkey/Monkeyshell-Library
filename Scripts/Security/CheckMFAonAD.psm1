<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

Import-Module ActiveDirectory

Get-ADUser -Filter * -Properties * | Where-Object { $_.SmartcardLogonRequired -ne $true } | Select-Object Name, UserPrincipalName
