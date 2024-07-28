extends Control

@onready var client_one = $HSplitContainer/VBoxContainer2/ClientOne
@onready var client_two = $HSplitContainer/VBoxContainer2/ClientTwo
@onready var client_three = $HSplitContainer/VBoxContainer2/ClientThree


# Called when the node enters the scene tree for the first time.
func _ready():
	client_one.text = "%01d %%" % GameManager.score_by_level['1'] 
	client_two.text = "%01d %%" % GameManager.score_by_level['2'] 
	client_three.text = "%01d %%" % GameManager.score_by_level['3'] 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click"):
		GameManager.change_state(GameManager.States.LOADING)

