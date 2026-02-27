# Anleitung für manuelle Screenshot-Erstellung

## Überblick

Diese Anleitung erklärt, wie du systematisch Screenshots aller Spotify-Profile der verdächtigen KI-Künstler erstellst und im Repository speicherst.

## Vorbereitung

### 1. Repository-Struktur

**Speicherort der Screenshots**: `c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots\`

Der Ordner wurde bereits erstellt. Alle Screenshots müssen in diesem Ordner gespeichert werden.

### 2. Benötigte Werkzeuge

- Webbrowser (Chrome, Firefox, Edge, etc.)
- Spotify Web Player: https://open.spotify.com
- Screenshot-Tool (Windows: Snipping Tool, Mac: Cmd+Shift+4, etc.)

## Systematische Vorgehensweise

### Schritt 1: Künstler-Liste

Du musst Screenshots von 77 Künstlern erstellen:

**Hauptverdächtige (4)**:
1. Olexesh
2. Hanybal
3. Disarstar
4. Nimo

**Weitere Verdächtige (73)**:
5. 249icey
6. 2busy4time
7. 2dizzy
8. 2late
9. 52Blue
10. 7ventus
11. ALeiz
12. AP$
13. Alex Connor
14. Alexander Eder
15. Armando
16. ArniMakeItDrop
17. ArniTheSavage
18. Arrow
19. Artan67
20. Asterio
21. BNZO
22. BeSa
23. Beigerdon
24. Beneath040
25. Benten2030
26. Benzo Bailey
27. Bianco
28. Big Boy Playin
29. Big Joe
30. Blender
31. BluFeyza
32. Bount
33. Broll3
34. CAMO23
35. CHROME
36. CLA$$Y
37. CLean
38. CRO
39. CXDEX
40. CaSaSi
41. Cavy
42. Cee355
43. Cerejaa
44. ChaiN
45. Chaos41
46. Cheekyteo
47. Chris de Burgh
48. Constii
49. Cr7z
50. Creety915
51. Crispy
52. Cubbie
53. DAWY
54. DAYDREAMCHASER
55. DER400
56. DIRTY
57. DONDON
58. DXVE
59. DannyoD
60. Dasco44
61. Dave Classic
62. DaysOfRain
63. DeadlyFriday
64. Dean
65. Deek469
66. Dian
67. Don Rob
68. Don
69. Drogu
70. Dropped
71. Dropshoter
72. Dynon
73. EAzzzTside
74. EJames
75. ELIA
76. EMICIANO
77. ENQEZ

### Schritt 2: Für jeden Künstler

#### 2.1 Spotify-Profil aufrufen

1. Öffne https://open.spotify.com
2. Klicke auf das Suchfeld
3. Gib den Künstlernamen ein (z.B. "Hanybal")
4. Drücke Enter
5. Klicke auf den Künstler in den Suchergebnissen

#### 2.2 Screenshot erstellen

**Screenshot 1: Künstler-Profil**
- Erstelle einen Screenshot des kompletten Künstler-Profils
- Stelle sicher, dass folgende Informationen sichtbar sind:
  - Künstlername
  - Profilbild
  - Follower-Zahl
  - Verifizierungsstatus
  - Beliebteste Songs
  - Alben

**Screenshot 2: Diskografie**
- Scrolle nach unten zur Diskografie
- Erstelle einen Screenshot der Alben-Liste
- Stelle sicher, dass alle Alben sichtbar sind

**Screenshot 3: Veröffentlichungsdaten**
- Klicke auf ein Album
- Erstelle einen Screenshot der Track-Liste mit Veröffentlichungsdaten

#### 2.3 Screenshot speichern

**Dateinamen-Format**: `{künstlername}_{nummer}_{typ}.png`

Beispiele:
- `hanybal_001_profil.png`
- `hanybal_002_diskografie.png`
- `hanybal_003_tracks.png`

**Speicherort**: `c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots\`

### Schritt 3: Dokumentation

Nachdem du Screenshots für einen Künstler erstellt hast, aktualisiere die Datei `SPOTIFY_EVIDENZ.md`:

```markdown
### 2. Hanybal

**Screenshot-Dateien**:
- `spotify_screenshots/hanybal_001_profil.png`
- `spotify_screenshots/hanybal_002_diskografie.png`
- `spotify_screenshots/hanybal_003_tracks.png`

**Spotify-URL**: [URL einfügen]
**Erstellungsdatum**: 27.02.2026
**Status**: Screenshots erstellt, im Repository gespeichert

**Sichtbare Informationen**:
- Künstlername: Hanybal
- Follower-Zahl: [Zahl]
- Verifizierungsstatus: [Ja/Nein]
- Beliebteste Songs: [Liste]
- Alben: [Liste]

**Diskografie**:
- [Album 1]
- [Album 2]
- [Album 3]
```

### Schritt 4: Wiederhole für alle Künstler

Wiederhole Schritte 2 und 3 für alle 77 Künstler.

## Qualitätssicherung

### Checkliste für jeden Screenshot

- [ ] Künstlername ist deutlich sichtbar
- [ ] Profilbild ist sichtbar
- [ ] Follower-Zahl ist lesbar
- [ ] Veröffentlichungsdaten sind lesbar
- [ ] Dateiname folgt dem korrekten Format
- [ ] Screenshot ist im korrekten Ordner gespeichert
- [ ] Screenshot ist nicht zu dunkel oder verwaschen

### Häufige Fehler vermeiden

1. **Falscher Dateiname**: Verwende immer Kleinbuchstaben und Unterstriche
2. **Falscher Speicherort**: Speichere immer im `spotify_screenshots`-Ordner
3. **Unvollständige Screenshots**: Stelle sicher, dass alle relevanten Informationen sichtbar sind
4. **Verschwommene Screenshots**: Verwende ein hochauflösendes Screenshot-Tool

## Automatisierung (optional)

Wenn du mit Skripten vertraut bist, kannst du die folgenden Tools verwenden:

### Python mit Selenium

```python
from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import os

# Konfiguration
SPOTIFY_URL = "https://open.spotify.com"
SCREENSHOT_DIR = "c:\\Users\\x\\Documents\\GitHub\\NWO-Das-Cybermobbing-Kartell\\spotify_screenshots"

# Künstler-Liste
artists = [
    "Olexesh",
    "Hanybal",
    "Disarstar",
    "Nimo",
    # ... alle 77 Künstler
]

# Browser starten
driver = webdriver.Chrome()

for i, artist in enumerate(artists):
    # Spotify öffnen
    driver.get(SPOTIFY_URL)
    
    # Suche
    search_box = driver.find_element(By.CSS_SELECTOR, "[data-testid='search-input']")
    search_box.send_keys(artist)
    search_box.send_keys(Keys.RETURN)
    
    # Warten auf Ergebnisse
    time.sleep(3)
    
    # Screenshot erstellen
    screenshot_path = os.path.join(SCREENSHOT_DIR, f"{artist.lower()}_{i+1:03d}_profil.png")
    driver.save_screenshot(screenshot_path)
    
    print(f"Screenshot erstellt: {screenshot_path}")

driver.quit()
```

### PowerShell mit Selenium

```powershell
# Installiere Selenium: Install-Module Selenium
Import-Module Selenium

$SPOTIFY_URL = "https://open.spotify.com"
$SCREENSHOT_DIR = "c:\Users\x\Documents\GitHub\NWO-Das-Cybermobbing-Kartell\spotify_screenshots"

$artists = @(
    "Olexesh",
    "Hanybal",
    "Disarstar",
    "Nimo"
    # ... alle 77 Künstler
)

$driver = Start-SeChrome

for ($i = 0; $i -lt $artists.Count; $i++) {
    $artist = $artists[$i]
    
    # Spotify öffnen
    $driver.Navigate().GoToUrl($SPOTIFY_URL)
    
    # Suche
    $searchBox = $driver.FindElement([OpenQA.Selenium.By]::CssSelector("[data-testid='search-input']"))
    $searchBox.SendKeys($artist)
    $searchBox.SendKeys([OpenQA.Selenium.Keys]::Enter)
    
    # Warten
    Start-Sleep -Seconds 3
    
    # Screenshot
    $screenshotPath = Join-Path $SCREENSHOT_DIR "$($artist.ToLower())_$($i+1)_profil.png"
    $driver.GetScreenshot().SaveAsFile($screenshotPath, [OpenQA.Selenium.ScreenshotImageFormat]::Png)
    
    Write-Host "Screenshot erstellt: $screenshotPath"
}

$driver.Quit()
```

## Fortschrittsverfolgung

### Aktualisiere SPOTIFY_EVIDENZ.md

Am Ende der Datei, aktualisiere den Fortschritt:

```markdown
## Zusammenfassung

**Stand der Dokumentation**: 27.02.2026
**Anzahl dokumentierter Künstler**: X von 77
**Fortschritt**: X%

### Abgeschlossene Künstler
- [x] Olexesh
- [x] Hanybal
- [ ] Disarstar
- [ ] Nimo
```

## Troubleshooting

### Problem: Künstler nicht gefunden

**Lösung**:
- Versuche alternative Schreibweisen
- Suche nach dem Künstler in Google und kopiere die exakte Schreibweise
- Prüfe, ob der Künstler tatsächlich auf Spotify existiert

### Problem: Screenshot zu groß

**Lösung**:
- Verwende ein Screenshot-Tool, das nur den sichtbaren Bereich aufnimmt
- Zoom heraus im Browser
- Erstelle mehrere Screenshots für lange Seiten

### Problem: Spotify lädt nicht

**Lösung**:
- Lösche Browser-Cache und Cookies
- Versuche einen anderen Browser
- Prüfe deine Internetverbindung

## Abschluss

Nachdem du alle 77 Künstler dokumentiert hast:

1. Überprüfe alle Screenshots auf Qualität
2. Stelle sicher, dass alle Dateien im korrekten Ordner sind
3. Aktualisiere SPOTIFY_EVIDENZ.md mit allen Informationen
4. Erstelle eine Zusammenfassung der Ergebnisse

## Nächste Schritte

1. Analysiere die Screenshots auf Inkonsistenzen
2. Vergleiche Veröffentlichungsdaten mit anderen Quellen
3. Dokumentiere verdächtige Muster
4. Erstelle einen Bericht über Backdating-Manipulationen

---

**Erstellt am**: 27.02.2026
**Version**: 1.0
