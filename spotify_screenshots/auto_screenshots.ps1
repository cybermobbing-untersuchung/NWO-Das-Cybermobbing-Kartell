# Automatische Screenshot-Erstellung
# Erstellt Screenshots aller 77 Künstler und speichert sie im Repository

$SCREENSHOT_DIR = "c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots"

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

# Für jeden Künstler
foreach ($artist in $artists) {
    $safeName = $artist -replace '[^a-zA-Z0-9]', '_'
    $screenshotPath = Join-Path $SCREENSHOT_DIR "$safeName`_001_profil.png"

    if (-not (Test-Path $screenshotPath)) {
        # Screenshot erstellen
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing

        $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
        $bitmap = New-Object System.Drawing.Bitmap $bounds.width, $bounds.height
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.CopyFromScreen($bounds.X, $bounds.Y, 0, 0, $bounds.size, [System.Drawing.CopyPixelOperation]::SourceCopy)

        $bitmap.Save($screenshotPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $graphics.Dispose()
        $bitmap.Dispose()

        Write-Host "Screenshot erstellt: $artist"
    }
}

Write-Host "Screenshots erstellt: $(Get-ChildItem -Path $SCREENSHOT_DIR -Filter *.png | Measure-Object).Count"
