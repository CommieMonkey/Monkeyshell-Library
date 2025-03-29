<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

$server = "8.8.8.8"
$pingResults = Test-Connection -ComputerName $server -Count 5
$avgLatency = ($pingResults | Measure-Object ResponseTime -Average).Average
Write-Host "Gemiddelde pingtijd naar $server: $avgLatency ms"
