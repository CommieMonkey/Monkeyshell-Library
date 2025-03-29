<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>


function Toon-Menu {
    Clear-Host
    Write-Host "============================="
    Write-Host "   Netwerk Security Check   "
    Write-Host "============================="
    Write-Host "1. Poortscanner"
    Write-Host "2. Onbekende apparaten zoeken"
    Write-Host "3. Firewall-regels controleren"
    Write-Host "4. Actieve netwerkverbindingen tonen"
    Write-Host "5. Mislukte inlogpogingen zoeken"
    Write-Host "6. Beheerdersaccounts bekijken"
    Write-Host "7. ARP-spoofing detecteren"
    Write-Host "0. Afsluiten"
    Write-Host "============================="
}

function Vraag-Invoer($vraag, $voorbeeld, $validatie) {
    do {
        $antwoord = Read-Host "$vraag (Voorbeeld: $voorbeeld)"
        if ($antwoord -match $validatie) {
            return $antwoord
        } else {
            Write-Host "Ongeldige invoer, probeer opnieuw."
        }
    } while ($true)
}

function Poortscanner {
    $subnet = Vraag-Invoer "Geef het subnet (eerste 3 blokken van een IP)" "192.168.1" "^\d{1,3}\.\d{1,3}\.\d{1,3}$"
    $poorten = Vraag-Invoer "Geef de poorten (gescheiden door komma’s)" "22, 80, 443" "^\d+(,\d+)*$"

    $poortLijst = $poorten -split "," | ForEach-Object { [int]$_ }
    Write-Host "Scannen van poorten..."
    
    foreach ($i in 1..254) {
        $ip = "$subnet.$i"
        foreach ($poort in $poortLijst) {
            if (Test-NetConnection -ComputerName $ip -Port $poort -InformationLevel Quiet) {
                Write-Host "Open poort: $ip:$poort"
            }
        }
    }
}

function Onbekende-Apparaten {
    $subnet = Vraag-Invoer "Geef het subnet" "192.168.1" "^\d{1,3}\.\d{1,3}\.\d{1,3}$"
    $toegestane_ips = Vraag-Invoer "Geef de bekende IP's (gescheiden door komma’s)" "192.168.1.1, 192.168.1.10" "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d+(,\s*\d{1,3}\.\d{1,3}\.\d{1,3}\.\d+)*$"

    $toegestaneLijst = $toegestane_ips -split ",\s*" 
    $huidige_apparaten = @()

    1..254 | ForEach-Object {
        $ip = "$subnet.$_"
        if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
            $huidige_apparaten += $ip
        }
    }

    $onbekende_apparaten = $huidige_apparaten | Where-Object { $_ -notin $toegestaneLijst }
    if ($onbekende_apparaten) {
        Write-Host "Onbekende apparaten gedetecteerd:"
        $onbekende_apparaten | ForEach-Object { Write-Host $_ }
    } else {
        Write-Host "Geen onbekende apparaten gedetecteerd."
    }
}

function Firewall-Check {
    Write-Host "Tonen van alle ingeschakelde firewallregels..."
    Get-NetFirewallRule | Where-Object { $_.Enabled -eq "True" } | Select-Object DisplayName, Direction, Action | Format-Table -AutoSize
}

function Netwerkverbindingen {
    Write-Host "Actieve netwerkverbindingen tonen..."
    netstat -an | Select-String "ESTABLISHED"
}

function Mislukte-Inlogpogingen {
    $dagen = Vraag-Invoer "Hoeveel dagen terug wil je scannen?" "1" "^\d+$"
    Get-WinEvent -FilterHashtable @{ LogName='Security'; ID=4625; StartTime=(Get-Date).AddDays(-[int]$dagen) } | Select-Object TimeCreated, Message
}

function Beheerders-Check {
    Write-Host "Lijst van lokale beheerders tonen..."
    Get-LocalGroupMember -Group "Administrators" | Select-Object Name
}

function ARP-Spoofing-Detectie {
    Write-Host "Scannen op ARP-spoofing..."
    $arp_table = arp -a
    $mac_adressen = @{}

    foreach ($line in $arp_table) {
        if ($line -match "(\d+\.\d+\.\d+\.\d+)\s+([a-fA-F0-9:-]+)") {
            $ip = $matches[1]
            $mac = $matches[2]
            if ($mac_adressen[$mac]) {
                Write-Host "⚠️  Mogelijke ARP-spoofing gedetecteerd! $mac wordt gedeeld door $ip en $mac_adressen[$mac]"
            } else {
                $mac_adressen[$mac] = $ip
            }
        }
    }
}

do {
    Toon-Menu
    $keuze = Read-Host "Kies een optie"

    switch ($keuze) {
        "1" { Poortscanner }
        "2" { Onbekende-Apparaten }
        "3" { Firewall-Check }
        "4" { Netwerkverbindingen }
        "5" { Mislukte-Inlogpogingen }
        "6" { Beheerders-Check }
        "7" { ARP-Spoofing-Detectie }
        "0" { Write-Host "Afsluiten..."; exit }
        default { Write-Host "❌ Ongeldige keuze, probeer opnieuw." }
    }

    Pause
} while ($true)
