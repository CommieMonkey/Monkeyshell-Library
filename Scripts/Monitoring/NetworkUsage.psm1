while ($true) {
    Get-NetAdapterStatistics | Format-Table Name, ReceivedBytes, SentBytes -AutoSize
    Start-Sleep -Seconds 5
    Clear-Host
}
