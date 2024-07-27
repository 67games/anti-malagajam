# anti-malagajam

### Game State Machine

(Draft)

```mermaid
flowchart TD
	Booting --> Start
	Start --> Game[Paint Tattoo]
	Game --> Pause
	Game --> Lost
	Game --> Win
	Win --> Exit
	Lost --> Exit
	Pause --> Exit
	Pause --> Game
	Win --> Game
	Lost --> Game
	Start --> Exit
```
