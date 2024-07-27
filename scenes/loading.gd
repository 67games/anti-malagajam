extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var next_state: GameManager.States
	if (GameManager.previous_state == GameManager.States.START):
		next_state = GameManager.States.PLAYING
	else:
		next_state = GameManager.States.START
	await get_tree().create_timer(randi_range(0,4)).timeout
	GameManager.change_state(next_state)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
