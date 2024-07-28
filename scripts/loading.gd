extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var next_state: GameManager.States
	if GameManager.after_loading_next_screen:
		await get_tree().create_timer(randi_range(1,3)).timeout
		GameManager.change_state(GameManager.after_loading_next_screen)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
