extends Node

@onready var timer = $Timer
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if label != null:
		label.text = "%01d" % timer.time_left
	

func _on_timer_timeout():
	label.queue_free()
	get_tree().paused = false
