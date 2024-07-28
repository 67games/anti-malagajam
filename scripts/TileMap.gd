extends TileMap

@export var level: int

@onready var tile_map = $"."
@onready var cursor = %Cursor
@onready var audio_stream_player_2d = $"../AudioStreamPlayer2D"
@onready var level_timer_label = $"../LevelTimer"

var score

var tattoo_layer = 1
var level_timer: Timer
var machine_sound = preload("res://assets/sounds/machine.mp3")

func _ready():
	GameManager.on_start_painting(_start_playing_sound)
	GameManager.on_stop_painting(_stop_playing_sound)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	level_timer = Timer.new()
	add_child(level_timer)
	level_timer.start(60)
	pass

func _process(_delta):
	level_timer_label.text = "%01d" % level_timer.time_left
	
	if level_timer.time_left < 1.0:
		GameManager.score_by_level[level] = score
		GameManager.change_state(GameManager.States.FINISHED)
		print(GameManager.score_by_level)

func _on_loop_sound(player):
	player.play()

func _start_playing_sound():
	if !audio_stream_player_2d.is_playing():
		audio_stream_player_2d.stream = machine_sound
		audio_stream_player_2d.connect("finished", Callable(self,"_on_loop_sound").bind(audio_stream_player_2d))
		audio_stream_player_2d.play()

func _stop_playing_sound():
	if audio_stream_player_2d.is_playing():
		audio_stream_player_2d.stop()

func _input(_event):
	
	if Input.is_action_just_pressed("click"):
		GameManager.start_painting()
	
	if Input.is_action_pressed("click"):
		if not GameManager.is_painting():
			return

		var tile_mouse_pos = tile_map.local_to_map(cursor.position)
		
		#Sustituir con las coordenadas correctas del tile del atlas
		var atlas_cord = Vector2i(1,0)
		
		tile_map.set_cell(tattoo_layer, tile_mouse_pos, 0, atlas_cord)
		
		var coincidences = (coincidence(tile_map.get_used_cells(0), tile_map.get_used_cells(1)).size() * 100) / tile_map.get_used_cells(0).size()
		
		var differences = ((difference(tile_map.get_used_cells(1), tile_map.get_used_cells(0)).size() * 100) / tile_map.get_used_cells(0).size()) * 0.25
		
		score = coincidences - differences if coincidences - differences > 0 else 0
		
		print("current score: ", score, "%")
		pass
	
	if Input.is_action_just_released("click"):
		GameManager.stop_painting()

func coincidence(arr1, arr2):
	var coincidences = []
	for v in arr1:
		if (v in arr2):
			coincidences.append(v)
	return coincidences
	
func difference(arr1, arr2):
	var differences = []
	for v in arr1:
		if not (v in arr2):
			differences.append(v)
	return differences
