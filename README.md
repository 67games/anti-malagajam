# anti-malagajam

## El Jardín Trasero

<a href="https://67games.itch.io/el-jardn-trasero">El Jardín Trasero by 67Games</a>

![<img src="[https://itch.io/embed/2860277?bg_color=000000&amp;fg_color=ffffff&amp;link_color=fa5c5c&amp;border_color=333333](https://img.itch.zone/aW1nLzE3MTAwMTUyLmdpZg==/180x143%23c/P2AM2h.gif)"/>](https://img.itch.zone/aW1nLzE3MTAwMTUyLmdpZg==/180x143%23c/P2AM2h.gif)

<a target="_blank" href="https://67games.itch.io/el-jardn-trasero" class="button">Play on itch.io</a>


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
