extends Control

@onready var mute_button = $MarginContainer/VBoxContainer/Mute

func _on_start_tattooing_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")



func _on_mute_pressed():
	if mute_button.text == "Mute":
		mute_button.text = "Unmute"
	else:
		mute_button.text = "Mute"



func _on_credits_pressed():
	pass # Replace with function body.



func _on_quit_the_job_pressed():
	get_tree().quit()
