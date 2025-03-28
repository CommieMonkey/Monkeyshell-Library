<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>


Get-ChildItem -Path C:\ -Recurse -File | Where-Object Length -GT 100MB | Select-Object FullName, Length
