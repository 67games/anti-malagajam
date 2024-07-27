extends Node2D

var IMPULSE_FORCE = 125

@onready var base_bar = %BaseBar
@onready var zone_bar = %ZoneBar
@onready var point_bar = %PointBar

var frames_since_last_direction_change = 0
var number_of_lives = 5 * 60 # Five seconds out of the zone
var random_y = randi_range(-1, 2)

# var should_point_fall = true

# Called when the node enters the scene tree for the first time.
func _ready():
	rand_from_seed(Time.get_ticks_msec())
	Engine.max_fps = 60
	point_bar.max_contacts_reported = 3
	point_bar.contact_monitor = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frames_since_last_direction_change+=1
	if frames_since_last_direction_change > 60:
		random_y = randi_range(-1, 1)
		frames_since_last_direction_change = 0
	if zone_bar.position.y <= -46:
		random_y = 1
	if zone_bar.position.y >= 46:
		random_y = -1
	zone_bar.position += Vector2(0, random_y*0.5)
	
	var distance = point_bar.position.distance_to(zone_bar.position)
	
	if distance > 20:
		number_of_lives -= 1
		print(number_of_lives)
	
	# if should_point_fall:
	# 	point_bar.position += Vector2(0, 1)
	pass

func _input(event):
	if event.is_action_pressed("Space"):
		# should_point_fall = false
		point_bar.apply_impulse(Vector2(0, -IMPULSE_FORCE))
	# if event.is_action_released("Space"):
		# should_point_fall = true
