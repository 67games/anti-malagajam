extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Fade in")
	await await get_tree().create_timer(1).timeout
	$AudioStreamPlayer.play()
	await await get_tree().create_timer(3).timeout
	$AnimationPlayer.play("Fade out")
	await await get_tree().create_timer(2).timeout
	$AnimationPlayer.play("Fade in")
	$Sprite2D.hide()
	await await get_tree().create_timer(4).timeout
	GameManager.change_state(GameManager.States.START)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
