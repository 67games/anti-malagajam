extends Control

@onready var client_one = $MarginContainer/HSplitContainer/VBoxContainer2/ClientOne
@onready var client_two = $MarginContainer/HSplitContainer/VBoxContainer2/ClientTwo
@onready var client_three = $MarginContainer/HSplitContainer/VBoxContainer2/ClientThree


# Called when the node enters the scene tree for the first time.
func _ready():
	client_one.text = "%01d %%" % GameManager.score_by_level['1'] 
	client_two.text = "%01d %%" % GameManager.score_by_level['2'] 
	client_three.text = "%01d %%" % GameManager.score_by_level['3']
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _go_to_menu():
	GameManager.change_state_with_loading(GameManager.States.START)
	
func _repeat_level():
	GameManager.change_state_with_loading(GameManager.States.READING)
