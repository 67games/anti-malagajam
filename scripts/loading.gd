extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var next_state: GameManager.States
	if (GameManager.previous_state == GameManager.States.SELECTING_LEVEL):
		next_state = GameManager.States.READING
	else:
		next_state = GameManager.States.START
	
	await get_tree().create_timer(randi_range(1,3)).timeout
	GameManager.change_state(next_state)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
