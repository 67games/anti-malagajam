extends Control

@onready var mute_button = $MarginContainer/VBoxContainer/Mute

func _on_start_tattooing_pressed():
	GameManager.change_state(GameManager.States.SELECTING_LEVEL)

func _on_mute_pressed():
	if mute_button.text == "Silenciar":
		mute_button.text = "Desilenciar"
	else:
		mute_button.text = "Silenciar"



func _on_credits_pressed():
	GameManager.change_state(GameManager.States.CREDITS)



func _on_quit_the_job_pressed():
	GameManager.change_state(GameManager.States.EXIT)
