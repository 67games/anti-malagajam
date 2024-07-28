extends Control

@onready var pause_menu = $"."



func _input(event):
	if event.is_action_pressed("Esc"):
		pause_game()
		
func pause_game():
	if GameManager.paused:
		GameManager.change_state(GameManager.States.PLAYING)
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		GameManager.change_state(GameManager.States.PAUSED)
		pause_menu.show()
		Engine.time_scale = 0
	GameManager.paused = !GameManager.paused
	
func _on_resume_pressed():
	pause_game()

func _on_back_to_menu_pressed():
	GameManager.change_state(GameManager.States.LOADING)
