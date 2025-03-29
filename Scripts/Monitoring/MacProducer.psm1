<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

arp -a | ForEach-Object {
    if ($_ -match "(\d+\.\d+\.\d+\.\d+)\s+([a-fA-F0-9:-]+)") {
        Write-Host "IP: $($matches[1]) - MAC: $($matches[2])"
    }
}
