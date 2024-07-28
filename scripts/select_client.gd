extends Control

func _on_first_client_pressed():
	GameManager.selected_level = "res://scenes/gameplay1.tscn"
	GameManager.selected_level_reading = "res://scenes/client_1.tscn"
	GameManager.change_state(GameManager.States.LOADING)

func _on_second_client_pressed():
	GameManager.selected_level = "res://scenes/gameplay2.tscn"
	GameManager.selected_level_reading = "res://scenes/client_2.tscn"
	GameManager.change_state(GameManager.States.LOADING)

func _on_third_client_pressed():
	GameManager.selected_level = "res://scenes/gameplay3.tscn"
	GameManager.selected_level_reading = "res://scenes/client_3.tscn"
	GameManager.change_state(GameManager.States.LOADING)

func _on_back_to_menu_pressed():
	GameManager.change_state(GameManager.States.START)
