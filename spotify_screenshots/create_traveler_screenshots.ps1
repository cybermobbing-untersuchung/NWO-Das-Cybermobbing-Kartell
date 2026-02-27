# Traveler Screenshot-Erstellung
# Erstellt Screenshots des Traveler-Profils und speichert sie im Repository

# Konfiguration
$SPOTIFY_URL = "https://open.spotify.com"
$SCREENSHOT_DIR = "c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots"
$LOG_FILE = "c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots\traveler_log.txt"

# Logging-Funktion
function Write-Log {
    param([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Write-Host $logMessage
    Add-Content -Path $LOG_FILE -Value $logMessage
}

# Screenshot-Funktion
function Take-Screenshot {
    param(
        [string]$filePath,
        [int]$delaySeconds = 2
    )

    try {
        # Wartezeit für Laden der Seite
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
function Create-TravelerScreenshots {
    Write-Log "=== Traveler Screenshot-Erstellung gestartet ==="
    Write-Log "Speicherort: $SCREENSHOT_DIR"
    Write-Log ""

    # Prüfe, ob Verzeichnis existiert
    if (-not (Test-Path $SCREENSHOT_DIR)) {
        Write-Log "Erstelle Verzeichnis: $SCREENSHOT_DIR"
        New-Item -ItemType Directory -Path $SCREENSHOT_DIR -Force | Out-Null
    }

    # Screenshots für Traveler
    $screenshots = @(
        @{Name = "Profil-Übersicht"; Filename = "traveler_001_profil.png"; Description = "Komplettes Profil des Traveler-Accounts"},
        @{Name = "Gefolgte Künstler"; Filename = "traveler_002_gefolgte_kuenstler.png"; Description = "Liste aller gefolgten Künstler"},
        @{Name = "Playlists"; Filename = "traveler_003_playlists.png"; Description = "Liste aller Playlists"}
    )

    foreach ($screenshot in $screenshots) {
        $screenshotPath = Join-Path $SCREENSHOT_DIR $screenshot.Filename

        Write-Log "Erstelle Screenshot: $($screenshot.Name)"
        Write-Log "  Datei: $screenshotPath"
        Write-Log "  Beschreibung: $($screenshot.Description)"

        # Prüfe, ob Screenshot bereits existiert
        if (Test-Path $screenshotPath) {
            Write-Log "  → Screenshot existiert bereits"
        }
        else {
            # Manuelles Screenshot erforderlich
            Write-Log "  → Manuelles Screenshot erforderlich:"
            Write-Log "    1. Öffne: $SPOTIFY_URL"
            Write-Log "    2. Melde dich mit dem Traveler-Konto an"
            Write-Log "    3. Navigiere zu: $($screenshot.Description)"
            Write-Log "    4. Erstelle einen Screenshot"
            Write-Log "    5. Speichere als: $screenshotPath"
        }

        Write-Log ""
    }

    Write-Log "=== Zusammenfassung ==="
    Write-Log "Bitte erstelle Screenshots für Traveler manuell gemäß den Anweisungen oben."
    Write-Log "Alle Screenshots müssen im Ordner gespeichert werden: $SCREENSHOT_DIR"
    Write-Log ""
    Write-Log "=== STATUS ==="
    $existingScreenshots = Get-ChildItem -Path $SCREENSHOT_DIR -Filter "traveler_*.png" -ErrorAction SilentlyContinue
    Write-Log "Vorhandene Traveler-Screenshots: $($existingScreenshots.Count)"
    Write-Log "Fehlende Traveler-Screenshots: $(3 - $existingScreenshots.Count)"
    Write-Log "Fortschritt: $([math]::Round(($existingScreenshots.Count / 3) * 100, 1))%"
}

# Skript ausführen
try {
    Create-TravelerScreenshots
}
catch {
    Write-Log "FEHLER: $_"
    Write-Log "Stack Trace: $($_.ScriptStackTrace)"
}

Write-Log ""
Write-Log "Log-Datei: $LOG_FILE"
Write-Log "Screenshot-Verzeichnis: $SCREENSHOT_DIR"
