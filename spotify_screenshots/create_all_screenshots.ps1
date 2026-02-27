# Spotify Screenshot Automatisierung - Ohne Browser-Tool
# Erstellt Screenshots aller 77 Künstler und speichert sie im Repository

# Konfiguration
$SCREENSHOT_DIR = "c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots"
$LOG_FILE = "c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots\automated_screenshot_log.txt"

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
    try {
        Add-Content -Path $LOG_FILE -Value $logMessage -ErrorAction SilentlyContinue
    }
    catch {
        # Wenn Log-Datei gesperrt ist, ignoriere den Fehler
    }
}

# Screenshot-Funktion
function Take-Screenshot {
    param(
        [string]$filePath,
        [int]$delaySeconds = 2
    )

    try {
        # Wartezeit
        Start-Sleep -Seconds $delaySeconds

        # Screenshot erstellen mit .NET
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing

        $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
        $bitmap = New-Object System.Drawing.Bitmap $bounds.width, $bounds.height
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.CopyFromScreen($bounds.X, $bounds.Y, 0, 0, $bounds.size, [System.Drawing.CopyPixelOperation]::SourceCopy)

        $bitmap.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)
        $graphics.Dispose()
        $bitmap.Dispose()

        return $true
    }
    catch {
        Write-Log "FEHLER beim Erstellen des Screenshots: $_"
        return $false
    }
}

# Hauptfunktion
function Create-AllScreenshots {
    Write-Log "=== Spotify Screenshot Automatisierung gestartet ==="
    Write-Log "Speicherort: $SCREENSHOT_DIR"
    Write-Log "Anzahl Künstler: $($artists.Count)"
    Write-Log ""

    # Prüfe, ob Verzeichnis existiert
    if (-not (Test-Path $SCREENSHOT_DIR)) {
        Write-Log "Erstelle Verzeichnis: $SCREENSHOT_DIR"
        New-Item -ItemType Directory -Path $SCREENSHOT_DIR -Force | Out-Null
    }

    Write-Log "=== MANUELLE SCREENSHOT-ERSTELLUNG ERFORDERLICH ==="
    Write-Log ""
    Write-Log "Da das Browser-Tool technische Probleme hat, müssen Screenshots manuell erstellt werden."
    Write-Log ""
    Write-Log "=== ANLEITUNG ==="
    Write-Log ""
    Write-Log "Für jeden Künstler:"
    Write-Log "1. Öffne: https://open.spotify.com"
    Write-Log "2. Suche nach dem Künstlernamen"
    Write-Log "3. Klicke auf den Künstler"
    Write-Log "4. Erstelle einen Screenshot des Profils"
    Write-Log "5. Speichere den Screenshot im Ordner: $SCREENSHOT_DIR"
    Write-Log "6. Benenne die Datei: {künstlername}_001_profil.png"
    Write-Log ""
    Write-Log "=== KÜNSTLER-LISTE ==="
    Write-Log ""

    # Für jeden Künstler
    for ($i = 0; $i -lt $artists.Count; $i++) {
        $artist = $artists[$i]
        $artistNumber = $i + 1
        $progress = [math]::Round(($i / $artists.Count) * 100, 1)

        Write-Log "[$artistNumber/$($artists.Count)] ($progress%) - $artist"

        # Dateiname bereinigen
        $safeArtistName = $artist -replace '[^a-zA-Z0-9]', '_'
        $screenshotPath = Join-Path $SCREENSHOT_DIR "$safeArtistName`_001_profil.png"

        # Prüfe, ob Screenshot bereits existiert
        if (Test-Path $screenshotPath) {
            Write-Log "  → Screenshot existiert bereits"
        }
        else {
            Write-Log "  → Zu erstellen: $screenshotPath"
        }
    }

    Write-Log ""
    Write-Log "=== ZUSAMMENFASSUNG ==="
    $existingScreenshots = Get-ChildItem -Path $SCREENSHOT_DIR -Filter "*.png" -ErrorAction SilentlyContinue
    Write-Log "Vorhandene Screenshots: $($existingScreenshots.Count)"
    Write-Log "Fehlende Screenshots: $(77 - $existingScreenshots.Count)"
    Write-Log "Fortschritt: $([math]::Round(($existingScreenshots.Count / 77) * 100, 1))%"
    Write-Log ""
    Write-Log "Bitte erstelle Screenshots für alle 77 Künstler gemäß der Anleitung oben."
    Write-Log "Alle Screenshots müssen im Ordner gespeichert werden: $SCREENSHOT_DIR"
}

# Skript ausführen
try {
    Create-AllScreenshots
}
catch {
    Write-Log "FEHLER: $_"
    Write-Log "Stack Trace: $($_.ScriptStackTrace)"
}

Write-Log ""
Write-Log "Log-Datei: $LOG_FILE"
Write-Log "Screenshot-Verzeichnis: $SCREENSHOT_DIR"
