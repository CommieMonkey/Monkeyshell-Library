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

function Poortscanner {
    $subnet = "192.168.1"
    $poorten = @(21, 22, 23, 25, 53, 80, 443, 3389)
    Write-Host "Scannen van poorten..."
    foreach ($i in 1..254) {
        $ip = "$subnet.$i"
        foreach ($poort in $poorten) {
            if (Test-NetConnection -ComputerName $ip -Port $poort -InformationLevel Quiet) {
                Write-Host "Open poort: $ip:$poort"
            }
        }
    }
}

function Onbekende-Apparaten {
    $toegestane_ips = @("192.168.1.1", "192.168.1.2", "192.168.1.10")
    $huidige_apparaten = @()

    1..254 | ForEach-Object {
        $ip = "192.168.1.$_"
        if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
            $huidige_apparaten += $ip
        }
    }

    $onbekende_apparaten = $huidige_apparaten | Where-Object { $_ -notin $toegestane_ips }
    if ($onbekende_apparaten) {
        Write-Host "Onbekende apparaten gedetecteerd:"
        $onbekende_apparaten | ForEach-Object { Write-Host $_ }
    } else {
        Write-Host "Geen onbekende apparaten gedetecteerd."
    }
}

function Firewall-Check {
    Get-NetFirewallRule | Where-Object { $_.Enabled -eq "True" } | Select-Object DisplayName, Direction, Action | Format-Table -AutoSize
}

function Netwerkverbindingen {
    netstat -an | Select-String "ESTABLISHED"
}

function Mislukte-Inlogpogingen {
    Get-WinEvent -FilterHashtable @{ LogName='Security'; ID=4625; StartTime=(Get-Date).AddDays(-1) } | Select-Object TimeCreated, Message
}

function Beheerders-Check {
    Get-LocalGroupMember -Group "Administrators" | Select-Object Name
}

function ARP-Spoofing-Detectie {
    $arp_table = arp -a
    $mac_adressen = @{}

    foreach ($line in $arp_table) {
        if ($line -match "(\d+\.\d+\.\d+\.\d+)\s+([a-fA-F0-9:-]+)") {
            $ip = $matches[1]
            $mac = $matches[2]
            if ($mac_adressen[$mac]) {
                Write-Host "Waarschuwing: Mogelijke ARP-spoofing gedetecteerd! $mac wordt gedeeld door $ip en $mac_adressen[$mac]"
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
        default { Write-Host "Ongeldige keuze, probeer opnieuw." }
    }

    Pause
} while ($true)
