<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>

Get-WinEvent -FilterHashtable @{
    LogName='Security'; 
    ID=4625;
    StartTime=(Get-Date).AddDays(-1)
} | Select-Object TimeCreated, Message
