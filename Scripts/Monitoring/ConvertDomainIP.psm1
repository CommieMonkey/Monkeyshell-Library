$domein = "google.com"
$ip = [System.Net.Dns]::GetHostAddresses($domein) | Select-Object -ExpandProperty IPAddressToString
Write-Host "$domein heeft IP-adres: $ip"

$reverseLookup = [System.Net.Dns]::GetHostEntry($ip).HostName
Write-Host "IP $ip behoort toe aan: $reverseLookup"
