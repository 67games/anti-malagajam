extends Control

@onready var pause_menu = $"."

var _old_start_painting_hooks = []
var _old_stop_painting_hooks = []

func _input(event):
	if event.is_action_pressed("Esc"):
		pause_game()

func _stash_painting_hooks():
	_old_start_painting_hooks = GameManager.get_start_painting_hooks()
	_old_stop_painting_hooks = GameManager.get_stop_painting_hooks()

func _pop_painting_hooks():
	for hook in _old_start_painting_hooks:
		GameManager.on_start_painting(hook)
	for hook in _old_stop_painting_hooks:
		GameManager.on_stop_painting(hook)

func pause_game():
	if GameManager.paused:
		GameManager.change_state(GameManager.States.PLAYING)
		pause_menu.hide()
		Engine.time_scale = 1
		_pop_painting_hooks()
	else:
		_stash_painting_hooks()
		GameManager.stop_painting()
		GameManager.change_state(GameManager.States.PAUSED)
		pause_menu.show()
		Engine.time_scale = 0
	GameManager.paused = !GameManager.paused
	
func _on_resume_pressed():
	pause_game()

func _on_back_to_menu_pressed():
	GameManager.change_state_with_loading(GameManager.States.START)
