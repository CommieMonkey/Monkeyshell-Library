<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

$admin_group = Get-LocalGroupMember -Group "Administrators"

foreach ($member in $admin_group) {
    Write-Host "Lid van beheerdersgroep: $($member.Name)"
}
