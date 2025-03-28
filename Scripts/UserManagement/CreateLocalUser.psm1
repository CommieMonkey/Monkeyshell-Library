<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>


New-LocalUser -Name "TestUser" -Password (ConvertTo-SecureString "P@ssw0rd!" -AsPlainText -Force) -FullName "Test User" -Description "Test account"
