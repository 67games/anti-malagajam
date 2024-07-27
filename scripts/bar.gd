extends Node2D

var IMPULSE_FORCE = 125
var SHAKE_RATE = 0.05

@onready var base_bar = %BaseBar
@onready var zone_bar = %ZoneBar
@onready var point_bar = %PointBar
@onready var cursor = %Cursor

var frames_since_last_direction_change = 0
var random_y = randi_range(-1, 2)
var initial_position_zone_bar_x

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	rand_from_seed(Time.get_ticks_msec())
	Engine.max_fps = 60
	
	GameManager.on_start_painting(_stop_point_bar)
	GameManager.on_stop_painting(_start_point_bar)
	
	initial_position_zone_bar_x = zone_bar.position.x
	pass

func _stop_point_bar():
	point_bar.freeze = true
	
func _start_point_bar():
	point_bar.freeze = false

func _process(_delta):
	
	var global_position = get_global_mouse_position()
	cursor.position = global_position

	if not GameManager.is_painting():
		frames_since_last_direction_change+=1
		if frames_since_last_direction_change > 60:
			random_y = randi_range(-1, 1)
			frames_since_last_direction_change = 0
		if zone_bar.position.y <= -36.5:
			random_y = 1
		if zone_bar.position.y >= 51.5:
			random_y = -1
		zone_bar.position += Vector2(0, random_y*0.5)

	var distance = point_bar.position.distance_to(zone_bar.position)
		
	if distance > 20:
		# shake by distance
		distance = abs(distance - 20)
		var shake = distance * SHAKE_RATE
		cursor.position = (Vector2(cursor.position.x + [-1, 1][randi_range(0,1)] * shake, 
			cursor.position.y + [-1, 1][randi_range(0,1)] * shake))
	pass
	

func _input(event):
	
	if event.is_action_pressed("Space"):
		point_bar.apply_impulse(Vector2(0, -IMPULSE_FORCE))
	pass
		
