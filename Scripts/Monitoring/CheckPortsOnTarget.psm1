$ip = "192.168.1.1"  # Pas dit aan naar de gewenste host
$poorten = @(22, 80, 443, 3389)  # Voeg meer poorten toe indien nodig

foreach ($poort in $poorten) {
    if (Test-NetConnection -ComputerName $ip -Port $poort -InformationLevel Quiet) {
        Write-Host "Poort $poort is open op $ip"
    } else {
        Write-Host "Poort $poort is gesloten op $ip"
    }
}
