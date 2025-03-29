$interfaces = Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv4" }
foreach ($interface in $interfaces) {
    Write-Host "Interface: $($interface.InterfaceAlias)"
    Write-Host "IP-adres: $($interface.IPAddress)"
    Write-Host "Subnetmasker: $($interface.PrefixLength)"
    Write-Host "--------------------------"
}
