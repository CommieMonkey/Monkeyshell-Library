<# 
Author: Thomas Van Aert
License: CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/)
Description: [Brief script description]
Note: You may NOT modify or redistribute this script without my permission.
#>



function Toon-Menu {
    Clear-Host
    Write-Host "==============================="
    Write-Host "   🖥️  Systeemonderhoud & Performance  "
    Write-Host "==============================="
    Write-Host "1. Controleer CPU, RAM, en schijfgebruik"
    Write-Host "2. Controleer uptime van systemen"
    Write-Host "3. Zet ongebruikte services uit"
    Write-Host "4. Systeemoptimalisatie (opschonen)"
    Write-Host "5. Beheer achtergrondprocessen"
    Write-Host "6. Controleer software-updates"
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

function Systeemgebruik-Check {
    Write-Host "💻 Monitoren van systeembronnen (CPU, RAM, Schijfgebruik)..."
    $cpu = Get-WmiObject -Class Win32_Processor | Select-Object LoadPercentage
    $ram = Get-WmiObject -Class Win32_OperatingSystem | Select-Object @{Name="TotalVisibleMemorySize"; Expression={$_.'TotalVisibleMemorySize'/1MB}}, @{Name="FreePhysicalMemory"; Expression={$_.'FreePhysicalMemory'/1MB}}
    $schijf = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | Select-Object DeviceID, @{Name="FreeSpace"; Expression={($_.FreeSpace/1GB)}}, @{Name="Size"; Expression={($_.Size/1GB)}}

    Write-Host "💾 CPU belasting: $($cpu.LoadPercentage)%"
    Write-Host "🧠 Geheugen gebruik: $($ram.TotalVisibleMemorySize - $ram.FreePhysicalMemory) MB van $($ram.TotalVisibleMemorySize) MB"
    Write-Host "💻 Schijfgebruik: "
    $schijf | ForEach-Object { Write-Host "$($_.DeviceID): $($_.FreeSpace) GB beschikbaar van $($_.Size) GB" }
}

function SysteemUptime {
    Write-Host "⏳ Controleer uptime van systemen..."
    $uptime = (Get-Date) - (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
    Write-Host "Systeem uptime: $($uptime.Days) dagen, $($uptime.Hours) uren, $($uptime.Minutes) minuten"
}

function Zet-Services-Uit {
    $serviceNaam = Vraag-Invoer "Geef de naam van de service die je wilt uitschakelen" "wuauserv" "^[\w-]+$"
    Write-Host "🔴 Probeer de service $serviceNaam uit te schakelen..."
    try {
        Stop-Service -Name $serviceNaam -Force
        Set-Service -Name $serviceNaam -StartupType Disabled
        Write-Host "$serviceNaam is uitgeschakeld."
    } catch {
        Write-Host "❌ Kan service niet uitschakelen: $($serviceNaam)"
    }
}

function Systeemoptimalisatie {
    Write-Host "🧹 Systeemoptimalisatie: tijdelijke bestanden opschonen..."
    $tempDir = [System.IO.Path]::GetTempPath()
    $logDir = "C:\Windows\Logs"
    
    # Verwijderen van tijdelijke bestanden
    Remove-Item "$tempDir*" -Recurse -Force
    Remove-Item "$logDir\*" -Recurse -Force
    Write-Host "Alle tijdelijke bestanden en logbestanden zijn verwijderd."

    # Schijfopruiming
    Write-Host "🧹 Start Schijfopruiming..."
    cleanmgr /sagerun:1
}

function AchtergrondProcessen {
    Write-Host "🛠️ Beheer achtergrondprocessen..."
    Get-Process | Select-Object Name, CPU, Id, @{Name="Memory (MB)"; Expression={[math]::round($_.WorkingSet / 1MB, 2)}} | Format-Table -AutoSize
    $processNaam = Vraag-Invoer "Geef de naam van het proces dat je wilt beëindigen" "chrome" "^[a-zA-Z0-9]+$"
    try {
        Stop-Process -Name $processNaam -Force
        Write-Host "🔴 Proces $processNaam is gestopt."
    } catch {
        Write-Host "❌ Kan proces $processNaam niet stoppen."
    }
}

function Software-Updates {
    Write-Host "🔄 Controleer op software-updates..."
    $updates = Get-WmiObject -Class Win32_QuickFixEngineering
    if ($updates) {
        $updates | Select-Object Description, HotFixID, InstalledOn | Format-Table -AutoSize
    } else {
        Write-Host "Er zijn geen software-updates geïnstalleerd."
    }
}

do {
    Toon-Menu
    $keuze = Read-Host "Kies een optie"

    switch ($keuze) {
        "1" { Systeemgebruik-Check }
        "2" { SysteemUptime }
        "3" { Zet-Services-Uit }
        "4" { Systeemoptimalisatie }
        "5" { AchtergrondProcessen }
        "6" { Software-Updates }
        "0" { Write-Host "👋 Afsluiten..."; exit }
        default { Write-Host "❌ Ongeldige keuze, probeer opnieuw." }
    }

    Pause
} while ($true)
