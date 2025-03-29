<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

$interfaces = Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv4" }
foreach ($interface in $interfaces) {
    Write-Host "Interface: $($interface.InterfaceAlias)"
    Write-Host "IP-adres: $($interface.IPAddress)"
    Write-Host "Subnetmasker: $($interface.PrefixLength)"
    Write-Host "--------------------------"
}
