<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

$domein = "google.com"
$ip = [System.Net.Dns]::GetHostAddresses($domein) | Select-Object -ExpandProperty IPAddressToString
Write-Host "$domein heeft IP-adres: $ip"

$reverseLookup = [System.Net.Dns]::GetHostEntry($ip).HostName
Write-Host "IP $ip behoort toe aan: $reverseLookup"
