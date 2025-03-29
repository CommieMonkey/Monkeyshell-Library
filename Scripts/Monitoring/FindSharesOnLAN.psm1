$computers = (Get-ADComputer -Filter *).Name  # Vereist Active Directory
foreach ($computer in $computers) {
    Write-Host "Gedeelde mappen op $computer:"
    net view \\$computer
}
