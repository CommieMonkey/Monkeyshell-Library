<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

$blacklist_poorten = @(21, 23, 25, 3389) # Pas aan op basis van je beleid

Get-NetFirewallRule | Where-Object { $_.Enabled -eq "True" } | ForEach-Object {
    if ($_.LocalPort -in $blacklist_poorten) {
        Write-Host "Waarschuwing: Open firewallpoort gedetecteerd - $($_.DisplayName) op poort $($_.LocalPort)"
    }
}
