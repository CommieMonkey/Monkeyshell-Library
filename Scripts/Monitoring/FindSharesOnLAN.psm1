<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

$computers = (Get-ADComputer -Filter *).Name  # Vereist Active Directory
foreach ($computer in $computers) {
    Write-Host "Gedeelde mappen op $computer:"
    net view \\$computer
}
