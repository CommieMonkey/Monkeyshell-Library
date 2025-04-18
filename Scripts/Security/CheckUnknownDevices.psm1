<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

$toegestane_ips = @("192.168.1.1", "192.168.1.2", "192.168.1.10")  # Voeg bekende apparaten toe
$huidige_apparaten = @()

1..254 | ForEach-Object {
    $ip = "192.168.1.$_"
    if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
        $huidige_apparaten += $ip
    }
}

$onbekende_apparaten = $huidige_apparaten | Where-Object { $_ -notin $toegestane_ips }
if ($onbekende_apparaten) {
    Write-Host "Waarschuwing! Onbekende apparaten gedetecteerd:"
    $onbekende_apparaten | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "Geen onbekende apparaten gedetecteerd."
}
