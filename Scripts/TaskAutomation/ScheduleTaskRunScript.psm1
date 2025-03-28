<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>


$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File C:\Scripts\Test.ps1"
$Trigger = New-ScheduledTaskTrigger -Daily -At 8am
Register-ScheduledTask -TaskName "RunTestScript" -Action $Action -Trigger $Trigger -User "SYSTEM" -RunLevel Highest
