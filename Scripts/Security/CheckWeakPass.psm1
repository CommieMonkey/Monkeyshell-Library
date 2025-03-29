<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

$subnet = "192.168.1"

foreach ($i in 1..254) {
    $ip = "$subnet.$i"

    # Controleer of SMB toegankelijk is zonder inloggegevens
    if (Test-NetConnection -ComputerName $ip -Port 445 -InformationLevel Quiet) {
        Write-Host "Mogelijk onbeveiligde SMB-deling gevonden op: $ip"
    }

    # Controleer of RDP (Remote Desktop) openstaat
    if (Test-NetConnection -ComputerName $ip -Port 3389 -InformationLevel Quiet) {
        Write-Host "RDP is open op: $ip - Zorg dat er sterke authenticatie wordt gebruikt!"
    }
}
