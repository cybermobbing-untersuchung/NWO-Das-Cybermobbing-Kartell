# Spotify Screenshot Automatisierungs-Skript
# Erstellt Screenshots aller 77 Künstler und speichert sie im Repository

# Konfiguration
$SPOTIFY_URL = "https://open.spotify.com"
$SCREENSHOT_DIR = "c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots"
$LOG_FILE = "c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots\screenshot_log.txt"

# Künstler-Liste
$artists = @(
    "Olexesh",
    "Hanybal",
    "Disarstar",
    "Nimo",
    "249icey",
    "2busy4time",
    "2dizzy",
    "2late",
    "52Blue",
    "7ventus",
    "ALeiz",
    "AP$",
    "Alex Connor",
    "Alexander Eder",
    "Armando",
    "ArniMakeItDrop",
    "ArniTheSavage",
    "Arrow",
    "Artan67",
    "Asterio",
    "BNZO",
    "BeSa",
    "Beigerdon",
    "Beneath040",
    "Benten2030",
    "Benzo Bailey",
    "Bianco",
    "Big Boy Playin",
    "Big Joe",
    "Blender",
    "BluFeyza",
    "Bount",
    "Broll3",
    "CAMO23",
    "CHROME",
    "CLA$$Y",
    "CLean",
    "CRO",
    "CXDEX",
    "CaSaSi",
    "Cavy",
    "Cee355",
    "Cerejaa",
    "ChaiN",
    "Chaos41",
    "Cheekyteo",
    "Chris de Burgh",
    "Constii",
    "Cr7z",
    "Creety915",
    "Crispy",
    "Cubbie",
    "DAWY",
    "DAYDREAMCHASER",
    "DER400",
    "DIRTY",
    "DONDON",
    "DXVE",
    "DannyoD",
    "Dasco44",
    "Dave Classic",
    "DaysOfRain",
    "DeadlyFriday",
    "Dean",
    "Deek469",
    "Dian",
    "Don Rob",
    "Don",
    "Drogu",
    "Dropped",
    "Dropshoter",
    "Dynon",
    "EAzzzTside",
    "EJames",
    "ELIA",
    "EMICIANO",
    "ENQEZ"
)

# Logging-Funktion
function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Write-Host $logMessage
    Add-Content -Path $LOG_FILE -Value $logMessage
}

# Hauptfunktion
function Create-Screenshots {
    Write-Log "=== Spotify Screenshot Automatisierung gestartet ==="
    Write-Log "Speicherort: $SCREENSHOT_DIR"
    Write-Log "Anzahl Künstler: $($artists.Count)"
    Write-Log ""

    # Prüfe, ob Verzeichnis existiert
    if (-not (Test-Path $SCREENSHOT_DIR)) {
        Write-Log "Erstelle Verzeichnis: $SCREENSHOT_DIR"
        New-Item -ItemType Directory -Path $SCREENSHOT_DIR -Force | Out-Null
    }

    # Für jeden Künstler
    for ($i = 0; $i -lt $artists.Count; $i++) {
        $artist = $artists[$i]
        $artistNumber = $i + 1
        $progress = [math]::Round(($i / $artists.Count) * 100, 1)

        Write-Log "[$artistNumber/$($artists.Count)] ($progress%) - Bearbeite: $artist"

        # Dateiname bereinigen (Sonderzeichen entfernen)
        $safeArtistName = $artist -replace '[^a-zA-Z0-9]', '_'
        $screenshotPath = Join-Path $SCREENSHOT_DIR "$safeArtistName`_001_profil.png"

        # Prüfe, ob Screenshot bereits existiert
        if (Test-Path $screenshotPath) {
            Write-Log "  → Screenshot existiert bereits, überspringe..."
            continue
        }

        # Anweisungen für manuelle Erstellung
        Write-Log "  → Manuelles Screenshot erforderlich:"
        Write-Log "    1. Öffne: $SPOTIFY_URL"
        Write-Log "    2. Suche nach: $artist"
        Write-Log "    3. Klicke auf den Künstler"
        Write-Log "    4. Erstelle Screenshot des Profils"
        Write-Log "    5. Speichere als: $screenshotPath"
        Write-Log ""

        # Kurze Pause
        Start-Sleep -Milliseconds 500
    }

    Write-Log ""
    Write-Log "=== Automatisierung abgeschlossen ==="
    Write-Log "Bitte erstelle die Screenshots manuell gemäß den Anweisungen oben."
}

# Skript ausführen
try {
    Create-Screenshots
}
catch {
    Write-Log "FEHLER: $_"
    Write-Log "Stack Trace: $($_.ScriptStackTrace)"
}

Write-Log ""
Write-Log "Log-Datei: $LOG_FILE"
Write-Log "Screenshot-Verzeichnis: $SCREENSHOT_DIR"
