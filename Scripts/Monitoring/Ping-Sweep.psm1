$subnet = "192.168.1"  # Pas dit aan naar jouw netwerk
1..254 | ForEach-Object {
    $ip = "$subnet.$_"
    if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
        Write-Host "Actief apparaat gevonden: $ip"
    }
}
