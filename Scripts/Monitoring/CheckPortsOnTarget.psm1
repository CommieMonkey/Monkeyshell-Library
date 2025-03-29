<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

$ip = "192.168.1.1"  # Pas dit aan naar de gewenste host
$poorten = @(22, 80, 443, 3389)  # Voeg meer poorten toe indien nodig

foreach ($poort in $poorten) {
    if (Test-NetConnection -ComputerName $ip -Port $poort -InformationLevel Quiet) {
        Write-Host "Poort $poort is open op $ip"
    } else {
        Write-Host "Poort $poort is gesloten op $ip"
    }
}
