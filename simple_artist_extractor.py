#!/usr/bin/env python3
"""
Einfacher Künstler-Extraktor aus MCP Browser Snapshot
Für die Doktorarbeit in Zusammenarbeit mit dem Bundesamt für Verfassungsschutz (BfV)
"""

import re
import datetime
import os

def extract_artists_from_snapshot(snapshot_file: str):
    """Extrahiert Künstler aus dem Snapshot"""
    
    with open(snapshot_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Finde alle Künstler-Namen (einfacher Ansatz)
    # Suche nach allen paragraph Zeilen mit Künstlernamen
    artist_pattern = r'paragraph \[ref=[^\]]+\]: ([^\s]+)'
    matches = re.findall(artist_pattern, content)
    
    # Filtere nur Künstler aus (keine Profile)
    artists = []
    for match in matches:
        # Überspringe, wenn es ein Profil ist (endet auf "Profile")
        if not match.endswith("Profile"):
            artists.append(match.strip())
    
    return artists

def save_artist_list(artists: list):
    """Speichert die Künstlerliste"""
    
    # Entferne Duplikate und sortiere
    unique_artists = sorted(list(set(artists)))
    
    # Erstelle Markdown-Datei
    content = f"""# Spotify Following Artists Collection

## Collection Details

- **User ID**: w5j8x1tlo0desiwgo7f0ulpc1
- **Collection Date**: {datetime.datetime.now().isoformat()}
- **Total Artists**: {len(unique_artists)}
- **Collection Method**: MCP Browser Integration
- **Source**: Spotify Web Interface

## Collected Artists

{chr(10).join(f"{i+1}. {artist}" for i, artist in enumerate(unique_artists))}

## Next Steps

1. **Detailed Profile Extraction**: Collect comprehensive data for each artist
2. **AI Analysis**: Run through advanced AI detection systems
3. **Bot Network Analysis**: Identify coordinated networks
4. **Security Assessment**: BfV classification and review
5. **Network Mapping**: Map relationships between artists

## Technical Notes

- **Data Source**: Direct Spotify Web Interface via MCP Browser
- **Extraction Method**: Pattern matching on DOM structure
- **Validation**: Manual verification required for detailed analysis
- **Quality**: Initial collection - requires enhancement

---

*Collection conducted for doctoral thesis in collaboration with BfV*
*Date: {datetime.datetime.now().isoformat()}*
"""
    
    with open(f"spotify_following_artists_{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.md", 'w', encoding='utf-8') as f:
        f.write(content)
    
    # Erstelle auch einfache Text-Datei für Weiterverarbeitung
    with open("artists_list.txt", 'w', encoding='utf-8') as f:
        for artist in unique_artists:
            f.write(f"{artist}\n")
    
    print(f"✅ {len(unique_artists)} Künstler extrahiert und gespeichert")
    return unique_artists

def main():
    """Hauptfunktion"""
    print("🎵 Einfacher Künstler-Extraktor")
    print("🛡️ BfV Security Integration")
    print("=" * 50)
    
    snapshot_path = "C:/Users/x/AppData/Local/Temp/windsurf/mcp_output_5bd01ba82ad9b085.txt"
    
    if os.path.exists(snapshot_path):
        print(f"📂 Verarbeite Snapshot: {snapshot_path}")
        artists = extract_artists_from_snapshot(snapshot_path)
        save_artist_list(artists)
        
        print(f"\n📊 Ergebnisse:")
        print(f"   Gesamt extrahiert: {len(artists)} Künstler")
        print(f"   Einzigartige Künstler: {len(set(artists))}")
        print(f"   Speicherort: artists_list.txt")
        
    else:
        print(f"❌ Snapshot nicht gefunden: {snapshot_path}")

if __name__ == "__main__":
    main()
