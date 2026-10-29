# Eigene Änderungen am Interaktionssystem

## 04.10.2026: Fehlertolerantes Laden der Streaming-Textur

`client/textures.lua` stellt `MurphyTextureReady()` bereit. Fehlende Texturen
werden höchstens einmal pro Sekunde erneut angefordert. Nach 30 Sekunden wird
ein Hinweis ausgegeben; ein später erfolgreicher Ladevorgang bleibt möglich.
Boolesche und numerische 0/1-Rückgaben werden ausdrücklich ausgewertet.

`client/interacts.lua` verwendet diese Prüfung statt des abbrechenden
`ox_lib`-Lade-Timeouts und einer unbegrenzten Warteschleife. Ohne Textur wird die
Darstellung der Interaktionen vorübergehend übersprungen. Beim nächsten
Darstellungsaufruf mit geladener Textur funktioniert sie wieder.

Die vorhandene `stream/redm_native_murphy.ytd` stimmt bytegenau mit dem geprüften
Repository-Stand überein. Die Ursache des clientseitigen Streaming-Ausfalls und
ein möglicher weiterer Fehler beim Spieleinstieg sind damit nicht behoben.

Prüfung: Lua-Syntaxprüfung beider Dateien; simulierte fehlende, verspätete und
numerisch/boolesch gemeldete Textur sowie Begrenzung der erneuten Anforderungen.
Im Spiel weiterhin Streaming nach neuem Verbindungsaufbau prüfen. Bei einem
Upstream-Update die beiden Dateien vergleichen und diese Fehlerbehandlung erhalten.
