$admin_group = Get-LocalGroupMember -Group "Administrators"

foreach ($member in $admin_group) {
    Write-Host "Lid van beheerdersgroep: $($member.Name)"
}
