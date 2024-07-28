extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	await await get_tree().create_timer(3).timeout
	GameManager.change_state(GameManager.States.START)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
