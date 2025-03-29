Get-SmbShare | ForEach-Object {
    Write-Host "Share: $($_.Name) - Toegang: $($_.Path)"
    Get-SmbShareAccess -Name $_.Name
}
