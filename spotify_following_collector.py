#!/usr/bin/env python3
"""
Spotify Following Collector mit MCP Browser Integration
Für die Doktorarbeit in Zusammenarbeit mit dem Bundesamt für Verfassungsschutz (BfV)
Automatisches Sammeln aller Künstler, denen Benutzer w5j8x1tlo0desiwgo7f0ulpc1 folgt
"""

import json
import datetime
import re
import time
import os
from typing import Dict, List, Optional
from dataclasses import dataclass

@dataclass
class SpotifyArtist:
    """Datenstruktur für Spotify-Künstler"""
    name: str
    spotify_id: str
    spotify_url: str
    monthly_listeners: int = 0
    followers: int = 0
    popularity: int = 0
    genres: List[str] = None
    image_url: str = ""
    collection_date: str = ""
    
    def __post_init__(self):
        if self.genres is None:
            self.genres = []
        if not self.collection_date:
            self.collection_date = datetime.datetime.now().isoformat()

class SpotifyFollowingCollector:
    def __init__(self):
        """Initialisiert den Spotify Following Collector"""
        self.user_id = "w5j8x1tlo0desiwgo7f0ulpc1"
        self.collected_artists = []
        self.collection_date = datetime.datetime.now().isoformat()
        self.base_url = "https://open.spotify.com"
        
        # Künstler, die bereits gesammelt wurden
        self.existing_artists = set()
        self.load_existing_artists()
        
    def load_existing_artists(self):
        """Lädt bereits gesammelte Künstler"""
        try:
            for file in os.listdir('.'):
                if file.endswith('.md') and file != 'README.md':
                    artist_name = file.replace('.md', '')
                    self.existing_artists.add(artist_name.lower())
        except Exception as e:
            print(f"❌ Fehler beim Laden vorhandener Künstler: {e}")
    
    def parse_artist_from_snapshot(self, snapshot_text: str) -> List[SpotifyArtist]:
        """Parst Künstler aus dem Browser-Snapshot"""
        artists = []
        
        # Einfacheres Regex-Muster für Künstler-Links
        # Suche nach allen Zeilen mit Artist-Buttons und Spotify-URLs
        lines = snapshot_text.split('\n')
        
        for line in lines:
            # Finde Artist-Button
            artist_match = re.search(r'- button "([^"]+) Artist"', line)
            if artist_match:
                button_name = artist_match.group(1).strip()
                
                # Suche in den nächsten Zeilen nach Link und Paragraph
                line_index = lines.index(line)
                
                # Suche in den nächsten 5 Zeilen nach Link und Spotify-ID
                spotify_id = None
                paragraph_name = None
                
                for i in range(line_index + 1, min(line_index + 6, len(lines))):
                    next_line = lines[i]
                    
                    # Finde Link mit Spotify-URL
                    if '/artist/' in next_line and not spotify_id:
                        link_match = re.search(r'- link "([^"]+)":\s*- /url: /artist/([^\s]+)', next_line)
                        if link_match:
                            spotify_id = link_match.group(2).strip()
                            
                    # Finde Paragraph mit dem Namen
                    if 'paragraph' in next_line and not paragraph_name:
                        para_match = re.search(r'paragraph \[ref=[^\]]+\]: ([^\s]+)', next_line)
                        if para_match:
                            paragraph_name = para_match.group(1).strip()
                    
                    # Breche ab, wenn beide gefunden
                    if spotify_id and paragraph_name:
                        break
                
                # Wenn beide Informationen gefunden wurden
                if spotify_id and paragraph_name:
                    artist = SpotifyArtist(
                        name=paragraph_name,
                        spotify_id=spotify_id,
                        spotify_url=f"{self.base_url}/artist/{spotify_id}",
                        collection_date=self.collection_date
                    )
                    artists.append(artist)
            
        return artists
    
    def create_artist_profile(self, artist: SpotifyArtist) -> str:
        """Erstellt ein Markdown-Profil für einen Künstler"""
        profile = f"""# {artist.name}

## Basic Information

- **Spotify ID**: {artist.spotify_id}
- **Spotify Link**: {artist.spotify_url}
- **Collection Date**: {artist.collection_date}
- **Monthly Listeners**: {artist.monthly_listeners:,}
- **Followers**: {artist.followers:,}
- **Popularity**: {artist.popularity}/100
- **Genres**: {', '.join(artist.genres) if artist.genres else 'N/A'}

## Profile Image
{f'![{artist.name}]({artist.image_url})' if artist.image_url else 'No image available'}

## Network Analysis

- **Classification**: To be determined
- **AI Probability**: To be analyzed
- **Bot Network Indicators**: To be analyzed
- **Security Assessment**: Pending BfV Review

## Data Collection Status

- **Status**: ✅ Collected via MCP Browser
- **Method**: Direct Spotify Web Interface
- **Completeness**: Basic profile collected
- **Next Steps**: Detailed analysis required

## Security Assessment

### BfV Classification
- **Risk Level**: To be determined
- **Priority**: Standard monitoring
- **Analysis Required**: Yes

### Recommended Actions
- **Detailed Analysis**: Full profile extraction needed
- **AI Detection**: Run through AI detection systems
- **Network Analysis**: Check for bot network connections

---

*This profile is part of a doctoral thesis project in collaboration with the Bundesamt für Verfassungsschutz (BfV).*
*Collected: {self.collection_date}*
*Status: Initial collection - Awaiting detailed analysis*
"""
        
        return profile
    
    def save_artist_profile(self, artist: SpotifyArtist):
        """Speichert das Künstlerprofil"""
        # Bereinige den Dateinamen
        safe_name = re.sub(r'[<>:"/\\|?*]', '_', artist.name)
        filename = f"{safe_name}.md"
        
        # Überspringe, wenn bereits vorhanden
        if artist.name.lower() in self.existing_artists:
            print(f"⏭️ Überspringe {artist.name} (bereits vorhanden)")
            return
            
        try:
            profile = self.create_artist_profile(artist)
            with open(filename, 'w', encoding='utf-8') as f:
                f.write(profile)
            print(f"✅ Profil gespeichert: {filename}")
            self.collected_artists.append(artist)
            self.existing_artists.add(artist.name.lower())
            
        except Exception as e:
            print(f"❌ Fehler beim Speichern von {artist.name}: {e}")
    
    def save_collection_summary(self):
        """Speichert eine Zusammenfassung der Sammlung"""
        summary = f"""# Spotify Following Collection Summary

## Collection Details

- **User ID**: {self.user_id}
- **Collection Date**: {self.collection_date}
- **Total Artists Collected**: {len(self.collected_artists)}
- **Collection Method**: MCP Browser Integration
- **Source**: Spotify Web Interface

## Collected Artists

{chr(10).join(f"- {artist.name} ({artist.spotify_id})" for artist in sorted(self.collected_artists, key=lambda x: x.name))}

## Next Steps

1. **Detailed Profile Extraction**: Collect comprehensive data for each artist
2. **AI Analysis**: Run through advanced AI detection systems
3. **Bot Network Analysis**: Identify coordinated networks
4. **Security Assessment**: BfV classification and review
5. **Network Mapping**: Map relationships between artists

## Technical Notes

- **Data Source**: Direct Spotify Web Interface via MCP Browser
- **Extraction Method**: Automated parsing of DOM structure
- **Validation**: Manual verification required for detailed analysis
- **Quality**: Initial collection - requires enhancement

---

*Collection conducted for doctoral thesis in collaboration with BfV*
*Date: {self.collection_date}*
"""
        
        try:
            with open(f"spotify_following_collection_{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.md", 'w', encoding='utf-8') as f:
                f.write(summary)
            print(f"✅ Zusammenfassung gespeichert")
        except Exception as e:
            print(f"❌ Fehler beim Speichern der Zusammenfassung: {e}")
    
    def process_snapshot_data(self, snapshot_file: str):
        """Verarbeitet die Snapshot-Daten aus dem MCP Browser"""
        try:
            with open(snapshot_file, 'r', encoding='utf-8') as f:
                snapshot_content = f.read()
            
            print(f"🔍 Verarbeite Snapshot-Daten...")
            
            # Extrahiere Künstler aus dem Snapshot
            artists = self.parse_artist_from_snapshot(snapshot_content)
            
            print(f"📊 {len(artists)} Künstler im Snapshot gefunden")
            
            # Speichere alle Künstler
            for i, artist in enumerate(artists, 1):
                print(f"📝 Speichere {i}/{len(artists)}: {artist.name}")
                self.save_artist_profile(artist)
                
                # Kurze Pause um Überlastung zu vermeiden
                time.sleep(0.01)
            
            # Speichere Zusammenfassung
            self.save_collection_summary()
            
            print(f"\n🎉 Sammlung abgeschlossen!")
            print(f"   Gesamt gesammelt: {len(self.collected_artists)} Künstler")
            print(f"   Bereits vorhanden: {len(self.existing_artists) - len(self.collected_artists)} Künstler")
            print(f"   Datum: {self.collection_date}")
            
        except Exception as e:
            print(f"❌ Fehler bei der Verarbeitung: {e}")

def main():
    """Hauptfunktion"""
    print("🎵 Spotify Following Collector mit MCP Browser Integration")
    print("🛡️ BfV Security Integration")
    print("📅 Doktorarbeit in Zusammenarbeit mit dem Bundesamt für Verfassungsschutz")
    print("=" * 70)
    
    collector = SpotifyFollowingCollector()
    
    # Pfad zur Snapshot-Datei (aus MCP Browser Ausgabe)
    snapshot_path = "C:/Users/x/AppData/Local/Temp/windsurf/mcp_output_5bd01ba82ad9b085.txt"
    
    if os.path.exists(snapshot_path):
        print(f"📂 Verarbeite Snapshot-Datei: {snapshot_path}")
        collector.process_snapshot_data(snapshot_path)
    else:
        print(f"❌ Snapshot-Datei nicht gefunden: {snapshot_path}")
        print("Bitte stellen Sie sicher, dass die MCP Browser Snapshot-Datei vorhanden ist.")

if __name__ == "__main__":
    main()
