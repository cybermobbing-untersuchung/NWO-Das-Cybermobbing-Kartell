# Traveler Screenshots erstellen

$SCREENSHOT_DIR = "c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots"

# Traveler Screenshots
$travelerScreenshots = @(
    @{Name = "traveler_001_profil.png"; Description = "Profil-Übersicht"},
    @{Name = "traveler_002_gefolgte_kuenstler.png"; Description = "Gefolgte Künstler"},
    @{Name = "traveler_003_playlists.png"; Description = "Playlists"}
)

# Verzeichnis erstellen
if (-not (Test-Path $SCREENSHOT_DIR)) {
    New-Item -ItemType Directory -Path $SCREENSHOT_DIR -Force | Out-Null
}

# Screenshots erstellen
foreach ($screenshot in $travelerScreenshots) {
    $screenshotPath = Join-Path $SCREENSHOT_DIR $screenshot.Name

    if (-not (Test-Path $screenshotPath)) {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing

        $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
        $bitmap = New-Object System.Drawing.Bitmap $bounds.width, $bounds.height
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.CopyFromScreen($bounds.X, $bounds.Y, 0, 0, $bounds.size, [System.Drawing.CopyPixelOperation]::SourceCopy)

        $bitmap.Save($screenshotPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $graphics.Dispose()
        $bitmap.Dispose()

        Write-Host "Screenshot erstellt: $($screenshot.Name)"
    }
}

Write-Host "Traveler Screenshots erstellt: $(Get-ChildItem -Path $SCREENSHOT_DIR -Filter traveler_*.png | Measure-Object).Count"
