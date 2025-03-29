$server = "8.8.8.8"
$pingResults = Test-Connection -ComputerName $server -Count 5
$avgLatency = ($pingResults | Measure-Object ResponseTime -Average).Average
Write-Host "Gemiddelde pingtijd naar $server: $avgLatency ms"
