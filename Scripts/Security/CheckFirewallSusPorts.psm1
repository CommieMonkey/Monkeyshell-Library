$blacklist_poorten = @(21, 23, 25, 3389) # Pas aan op basis van je beleid

Get-NetFirewallRule | Where-Object { $_.Enabled -eq "True" } | ForEach-Object {
    if ($_.LocalPort -in $blacklist_poorten) {
        Write-Host "Waarschuwing: Open firewallpoort gedetecteerd - $($_.DisplayName) op poort $($_.LocalPort)"
    }
}
