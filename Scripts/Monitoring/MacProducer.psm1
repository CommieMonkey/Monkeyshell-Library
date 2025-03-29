arp -a | ForEach-Object {
    if ($_ -match "(\d+\.\d+\.\d+\.\d+)\s+([a-fA-F0-9:-]+)") {
        Write-Host "IP: $($matches[1]) - MAC: $($matches[2])"
    }
}
