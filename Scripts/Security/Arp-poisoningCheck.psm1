$arp_table = arp -a
$mac_adressen = @{}

foreach ($line in $arp_table) {
    if ($line -match "(\d+\.\d+\.\d+\.\d+)\s+([a-fA-F0-9:-]+)") {
        $ip = $matches[1]
        $mac = $matches[2]
        if ($mac_adressen[$mac]) {
            Write-Host "Waarschuwing: Mogelijke ARP-spoofing gedetecteerd! $mac wordt gedeeld door $ip en $mac_adressen[$mac]"
        } else {
            $mac_adressen[$mac] = $ip
        }
    }
}
