extends Control

@onready var mute_button = $MarginContainer/VBoxContainer/Mute

func _on_start_tattooing_pressed():
	GameManager.change_state(GameManager.States.SELECTING_LEVEL)

func _on_mute_pressed():
	if mute_button.text == "Silenciar":
		mute_button.text = "Desilenciar"
		var bus_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(bus_idx, true) # or false
	else:
		mute_button.text = "Silenciar"
		var bus_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(bus_idx, false) # or false

func _on_credits_pressed():
	GameManager.change_state(GameManager.States.CREDITS)

func _on_quit_the_job_pressed():
	GameManager.change_state(GameManager.States.EXIT)
