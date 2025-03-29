$subnet = "192.168.1"
$poorten = @(22, 80, 443, 3389)

foreach ($i in 1..254) {
    $ip = "$subnet.$i"
    foreach ($poort in $poorten) {
        if (Test-NetConnection -ComputerName $ip -Port $poort -InformationLevel Quiet) {
            Write-Host "Open poort $poort gevonden op $ip"
        }
    }
}
