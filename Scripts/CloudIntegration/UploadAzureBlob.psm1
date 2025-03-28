<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: Upload a File to Azure Blob Storage (Using Az PowerShell)
Note: You may NOT modify or redistribute this script without my permission.
#>


Set-AzStorageBlobContent -File "C:\MyFile.txt" -Container "mycontainer" -Blob "MyFile.txt" -Context (Get-AzStorageAccount -Name "myaccount").Context
