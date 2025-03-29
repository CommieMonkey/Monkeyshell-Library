<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

while ($true) {
    Get-NetAdapterStatistics | Format-Table Name, ReceivedBytes, SentBytes -AutoSize
    Start-Sleep -Seconds 5
    Clear-Host
}
