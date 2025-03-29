<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>


function Toon-Menu {
    Clear-Host
    Write-Host "==============================="
    Write-Host "  🛡️  Beveiliging & Compliance  "
    Write-Host "==============================="
    Write-Host "1. Controleer antivirusstatus"
    Write-Host "2. Controleer Windows-updates"
    Write-Host "3. Scan open poorten"
    Write-Host "4. Detecteer brute-force aanvallen"
    Write-Host "5. Analyseer audit logs"
    Write-Host "6. Controleer beveiligingsbeleid"
    Write-Host "0. Afsluiten"
    Write-Host "==============================="
}

function Vraag-Invoer($vraag, $voorbeeld, $validatie) {
    do {
        $antwoord = Read-Host "$vraag (Voorbeeld: $voorbeeld)"
        if ($antwoord -match $validatie) {
            return $antwoord
        } else {
            Write-Host "❌ Ongeldige invoer, probeer opnieuw."
        }
    } while ($true)
}

function Antivirus-Check {
    Write-Host "🔍 Controleren op geïnstalleerde antivirussoftware..."
    Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Select-Object displayName, productState
}

function Windows-Updates {
    Write-Host "🔄 Controleren op Windows-updates..."
    Get-WindowsUpdateLog | Select-String "Installation"
}

function Poort-Scan {
    $subnet = Vraag-Invoer "Geef het subnet (eerste 3 blokken van een IP)" "192.168.1" "^\d{1,3}\.\d{1,3}\.\d{1,3}$"
    $poorten = Vraag-Invoer "Geef de poorten (gescheiden door komma’s)" "22, 80, 443" "^\d+(,\d+)*$"

    $poortLijst = $poorten -split "," | ForEach-Object { [int]$_ }
    Write-Host "📡 Scannen van open poorten..."
    
    foreach ($i in 1..254) {
        $ip = "$subnet.$i"
        foreach ($poort in $poortLijst) {
            if (Test-NetConnection -ComputerName $ip -Port $poort -InformationLevel Quiet) {
                Write-Host "🟢 Open poort gevonden: $ip:$poort"
            }
        }
    }
}

function Brute-Force-Detectie {
    $dagen = Vraag-Invoer "Hoeveel dagen terug wil je scannen?" "1" "^\d+$"
    Write-Host "🔐 Analyseren van mislukte inlogpogingen..."
    Get-WinEvent -FilterHashtable @{ LogName='Security'; ID=4625; StartTime=(Get-Date).AddDays(-[int]$dagen) } | Select-Object TimeCreated, Message
}

function Audit-Log-Analyse {
    Write-Host "📜 Analyseren van belangrijke audit logs..."
    Get-WinEvent -LogName Security | Select-Object TimeCreated, ID, Message | Out-GridView
}

function Beveiligingsbeleid-Check {
    Write-Host "🔎 Controleren van lokale beveiligingsinstellingen..."
    secedit /export /cfg C:\temp\secpol.cfg
    Get-Content C:\temp\secpol.cfg | Select-String "PasswordComplexity|MinimumPasswordAge|MaximumPasswordAge|LockoutDuration"
}

do {
    Toon-Menu
    $keuze = Read-Host "Kies een optie"

    switch ($keuze) {
        "1" { Antivirus-Check }
        "2" { Windows-Updates }
        "3" { Poort-Scan }
        "4" { Brute-Force-Detectie }
        "5" { Audit-Log-Analyse }
        "6" { Beveiligingsbeleid-Check }
        "0" { Write-Host "👋 Afsluiten..."; exit }
        default { Write-Host "❌ Ongeldige keuze, probeer opnieuw." }
    }

    Pause
} while ($true)
