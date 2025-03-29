<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

$computers = @("PC1", "PC2", "PC3") # Voeg computernamen toe

foreach ($computer in $computers) {
    $status = Invoke-Command -ComputerName $computer -ScriptBlock {
        Get-MpComputerStatus | Select-Object AMRunning
    }
    Write-Host "Defender status op $computer: $status"
}
