$domeinen = @("google.com", "192.168.1.1", "mijnserver.local")
foreach ($domein in $domeinen) {
    if (Test-Connection -ComputerName $domein -Count 2 -Quiet) {
        Write-Host "$domein is online"
    } else {
        Write-Host "$domein is OFFLINE!"
    }
}
