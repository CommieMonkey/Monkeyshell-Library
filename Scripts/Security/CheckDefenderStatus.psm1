$computers = @("PC1", "PC2", "PC3") # Voeg computernamen toe

foreach ($computer in $computers) {
    $status = Invoke-Command -ComputerName $computer -ScriptBlock {
        Get-MpComputerStatus | Select-Object AMRunning
    }
    Write-Host "Defender status op $computer: $status"
}
