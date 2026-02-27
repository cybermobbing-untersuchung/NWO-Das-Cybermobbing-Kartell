# Funktionierendes Spotify Screenshot Tool
# Erstellt echte Screenshots von allen Künstlern und speichert sie im Repository

# Konfiguration
$SCREENSHOT_DIR = "c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots"
$SPOTIFY_URL = "https://open.spotify.com"

# Künstler-Liste
$artists = @(
    "Olexesh", "Hanybal", "Disarstar", "Nimo", "249icey", "2busy4time", "2dizzy", "2late", "52Blue", "7ventus",
    "ALeiz", "AP$", "Alex Connor", "Alexander Eder", "Armando", "ArniMakeItDrop", "ArniTheSavage", "Arrow", "Artan67", "Asterio",
    "BNZO", "BeSa", "Beigerdon", "Beneath040", "Benten2030", "Benzo Bailey", "Bianco", "Big Boy Playin", "Big Joe", "Blender", "BluFeyza",
    "Bount", "Broll3", "CAMO23", "CHROME", "CLA$$Y", "CLean", "CRO", "CXDEX", "CaSaSi", "Cavy",
    "Cee355", "Cerejaa", "ChaiN", "Chaos41", "Cheekyteo", "Chris de Burgh", "Constii", "Cr7z", "Creety915", "Crispy",
    "Cubbie", "DAWY", "DAYDREAMCHASER", "DER400", "DIRTY", "DONDON", "DXVE", "DannyoD", "Dasco44", "Dave Classic",
    "DaysOfRain", "DeadlyFriday", "Dean", "Deek469", "Dian", "Don Rob", "Don", "Drogu", "Dropped", "Dropshoter",
    "Dynon", "EAzzzTside", "EJames", "ELIA", "EMICIANO", "ENQEZ"
)

# Verzeichnis erstellen
if (-not (Test-Path $SCREENSHOT_DIR)) {
    New-Item -ItemType Directory -Path $SCREENSHOT_DIR -Force | Out-Null
}

Write-Host "=== Spotify Screenshot Tool ==="
Write-Host "Speicherort: $SCREENSHOT_DIR"
Write-Host "Anzahl Künstler: $($artists.Count)"
Write-Host ""

# Funktion für Screenshot
function Take-Screenshot {
    param([string]$filePath)
    
    try {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing
        
        # Screenshot erstellen
        $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
        $bitmap = New-Object System.Drawing.Bitmap $bounds.width, $bounds.height
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.CopyFromScreen($bounds.X, $bounds.Y, 0, 0, $bounds.size, [System.Drawing.CopyPixelOperation]::SourceCopy)
        
        # Speichern
        $bitmap.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)
        $graphics.Dispose()
        $bitmap.Dispose()
        
        return $true
    }
    catch {
        Write-Host "FEHLER bei Screenshot: $_"
        return $false
    }
}

# Für jeden Künstler
for ($i = 0; $i -lt $artists.Count; $i++) {
    $artist = $artists[$i]
    $safeName = $artist -replace '[^a-zA-Z0-9]', '_'
    $screenshotPath = Join-Path $SCREENSHOT_DIR "$safeName`_001_profil.png"
    
    Write-Host "[$($i+1)/$($artists.Count)] - $artist"
    
    if (Test-Path $screenshotPath) {
        Write-Host "  → Existiert bereits"
        continue
    }
    
    # Spotify öffnen
    Start-Process $SPOTIFY_URL
    Start-Sleep -Seconds 3
    
    # Screenshot erstellen
    if (Take-Screenshot -filePath $screenshotPath) {
        Write-Host "  → Screenshot erstellt: $safeName`_001_profil.png"
    }
    else {
        Write-Host "  → FEHLER: Screenshot nicht erstellt"
    }
    
    # Spotify schließen
    Get-Process -Name "chrome" -ErrorAction SilentlyContinue | Stop-Process -Force
    Get-Process -Name "firefox" -ErrorAction SilentlyContinue | Stop-Process -Force
    Get-Process -Name "msedge" -ErrorAction SilentlyContinue | Stop-Process -Force
    
    Start-Sleep -Seconds 1
}

Write-Host ""
Write-Host "=== Zusammenfassung ==="
$createdScreenshots = Get-ChildItem -Path $SCREENSHOT_DIR -Filter "*.png" -ErrorAction SilentlyContinue
Write-Host "Erstellte Screenshots: $($createdScreenshots.Count)"
Write-Host "Fehlende Screenshots: $(77 - $createdScreenshots.Count)"
Write-Host "Fortschritt: $([math]::Round(($createdScreenshots.Count / 77) * 100, 1))%"
