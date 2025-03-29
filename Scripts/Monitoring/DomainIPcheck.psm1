<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

$domeinen = @("google.com", "192.168.1.1", "mijnserver.local")
foreach ($domein in $domeinen) {
    if (Test-Connection -ComputerName $domein -Count 2 -Quiet) {
        Write-Host "$domein is online"
    } else {
        Write-Host "$domein is OFFLINE!"
    }
}
