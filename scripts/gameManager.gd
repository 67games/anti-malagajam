extends Node

@export var DEBUGGING_GAMESTATES = true

var _is_painting = false
var _start_painting_hooks = []
var _stop_painting_hooks = []
var paused = false

var score_by_level = {
	'1': 0,
	'2': 0,
	'3': 0
}

var selected_level = "res://scenes/gameplay1.tscn"
var selected_level_reading = "res://scenes/client_1.tscn"

func is_painting():
	return _is_painting

func start_painting():
	if _is_painting:
		return

	for f in _start_painting_hooks:
		f.call()
	_is_painting = true
	
func stop_painting():
	if not _is_painting:
		return

	for f in _stop_painting_hooks:
		f.call()
	_is_painting = false

func _clean_painting_hooks():
	_start_painting_hooks = []
	_stop_painting_hooks =  []

func on_start_painting(f):
	_start_painting_hooks.push_back(f)
	
func on_stop_painting(f):
	_stop_painting_hooks.push_back(f)

# Possible Game States
enum States {
	# State of the game as it is starting
	BOOTING,
	# Intro Screen of the game
	INTRO_SCREEN,
	# Start Menu of the game
	START,
	# Loading sonme scene
	LOADING,
	# Selecting some level
	SELECTING_LEVEL,
	# Reading some lore
	READING,
	# Playing some level
	PLAYING,
	# When the player failed the game
	GAME_OVER,
	# When the game is paused
	PAUSED,
	# When the player has won the game
	FINISHED,
	# Exiting the game
	EXIT,
	# Checking credits
	CREDITS,
	# Tutorial Screen
	TUTORIAL
}

var current_state: States = States.BOOTING

var previous_state: States

var states_debug_names = {
	States.BOOTING: 'BOOTING (%s)' % States.BOOTING,
	States.INTRO_SCREEN: 'INTRO_SCREEN (%s)' % States.INTRO_SCREEN,
	States.START: 'START (%s)' % States.START,
	States.LOADING: 'LOADING (%s)' % States.LOADING,
	States.SELECTING_LEVEL: 'SELECTING_LEVEL (%s)' % States.SELECTING_LEVEL,
	States.READING: 'READING (%s)' % States.READING,
	States.PLAYING: 'PLAYING (%s)' % States.PLAYING,
	States.GAME_OVER: 'GAME_OVER (%s)' % States.GAME_OVER,
	States.PAUSED: 'PAUSED (%s)' % States.PAUSED,
	States.FINISHED: 'FINISHED (%s)' % States.FINISHED,
	States.EXIT: 'EXIT (%s)' % States.EXIT,
	States.CREDITS: 'CREDITS (%s)' % States.CREDITS,
	States.TUTORIAL: 'TUTORIAL (%s)' % States.TUTORIAL
}

# Dict saving unique possible next states
var possible_next_states = {
	States.BOOTING: {
		States.INTRO_SCREEN: _from_booting_to_intro_screen
	},
	States.INTRO_SCREEN: {
		States.START: _from_intro_screen_to_start
	},
	States.START: {
		States.EXIT: _exit,
		States.SELECTING_LEVEL: _from_start_to_selecting_level,
		States.CREDITS: _from_start_to_credits,
		States.TUTORIAL: _from_start_to_tutorial
	},
	States.LOADING: {
		States.START: _from_loading_to_start,
		States.READING: _from_loading_to_reading
	},
	States.READING: {
		States.PLAYING: _from_reading_to_playing
	},
	States.SELECTING_LEVEL: {
		States.START: _from_selecting_level_to_start,
		States.LOADING: _from_selecting_level_to_loading
	},
	States.PLAYING: {
		States.FINISHED: _from_playing_to_finished,
		States.GAME_OVER: _do_nothing,
		States.PAUSED: _do_nothing
	},
	States.GAME_OVER: {
		States.PLAYING: _do_nothing,
		States.LOADING: _from_gameover_to_loading
	},
	States.FINISHED: {
		States.PLAYING: _do_nothing,
		States.LOADING: _from_finished_to_loading
	},
	States.PAUSED: {
		States.PLAYING: _do_nothing,
		States.LOADING: _from_paused_to_loading
	},
	States.EXIT: {},
	States.CREDITS: {
		States.START: _from_credits_to_start
	},
	States.TUTORIAL: {
		States.START: _from_tutorial_to_start
	}
}

func _from_booting_to_intro_screen():
	get_tree().change_scene_to_file("res://scenes/initial_scene.tscn")

func _from_intro_screen_to_start():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _from_start_to_selecting_level():
	get_tree().change_scene_to_file("res://scenes/select_client.tscn")
	
func _from_selecting_level_to_start():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func _from_selecting_level_to_loading():
	get_tree().change_scene_to_file("res://scenes/loading.tscn")
	
func _from_gameover_to_loading():
	get_tree().change_scene_to_file("res://scenes/loading.tscn")

func _from_finished_to_loading():
	get_tree().change_scene_to_file("res://scenes/loading.tscn")
	
func _from_paused_to_loading():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/loading.tscn")
	
func _from_loading_to_start():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func _from_reading_to_playing():
	get_tree().change_scene_to_file(selected_level)
	
func _from_loading_to_reading():
	get_tree().change_scene_to_file(selected_level_reading)
	
func _from_playing_to_finished():
	get_tree().change_scene_to_file("res://scenes/results.tscn")
	
func _from_credits_to_start():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _from_start_to_credits():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	
func _from_start_to_tutorial():
	get_tree().change_scene_to_file("res://scenes/tuto.tscn")
	
func _from_tutorial_to_start():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _exit():
	print_debug('Exiting game')
	get_tree().quit()

func get_start_painting_hooks():
	return _start_painting_hooks
	
func get_stop_painting_hooks():
	return _stop_painting_hooks

# Temporal function for game state changes that do nothing
func _do_nothing():
	pass

var after_loading_next_screen = null

func change_state_with_loading(new_state):
	after_loading_next_screen = new_state
	change_state(States.LOADING)

# Change State executing required functions
func change_state(new_state):
	save_scores()
	stop_painting()
	_clean_painting_hooks()
	print_debug("change_state from %s to %s" % [states_debug_names[current_state], states_debug_names[new_state]])
	assert(new_state in possible_next_states[current_state], 'Game state change was ilegal')
	possible_next_states[current_state][new_state].call()
	previous_state = current_state
	current_state = new_state

func save_scores():
	var save_file = FileAccess.open("user://gamescores.save", FileAccess.WRITE)
	var json_string = JSON.stringify(score_by_level)
	save_file.store_line(json_string)
	
func load_scores():
	if not FileAccess.file_exists("user://gamescores.save"):
		return # Error! We don't have a save to load.
	var save_file = FileAccess.open("user://gamescores.save", FileAccess.READ)
	score_by_level = JSON.parse_string(save_file.get_as_text())
	print_debug(save_file.get_as_text())
	print_debug(score_by_level)
	
	print("LOADED LEVELS:\n\t1 => %s\n\t2 => %s\n\t3 => %s" % [
		score_by_level['1'],
		score_by_level['2'],
		score_by_level['3']
	])

func _ready():
	# print(get_tree().get_current_scene().name)
	if get_tree().get_current_scene().name == 'MainGame':
		load_scores()
		change_state(States.INTRO_SCREEN)
	# if get_tree().get_current_scene().name == 'Loading':
		# await get_tree().create_timer(4.0).timeout
		# change_state(States.START)
	
func _process(_delta):
	pass

func _input(event):
	if DEBUGGING_GAMESTATES:
		if event is InputEventKey and event.pressed:
			if event.keycode == KEY_0:
				change_state(States.BOOTING)
			if event.keycode == KEY_1:
				change_state(States.START)
			if event.keycode == KEY_2:
				change_state(States.PLAYING)
			if event.keycode == KEY_3:
				change_state(States.GAME_OVER)
			if event.keycode == KEY_4:
				change_state(States.PAUSED)
			if event.keycode == KEY_5:
				change_state(States.FINISHED)
			if event.keycode == KEY_6:
				change_state(States.EXIT)
				
			if event.keycode == KEY_F1:
				print('===============================================================================')
				print("Current State: %s" % [states_debug_names[current_state]])
				var next_states = ""
				for state in possible_next_states[current_state].keys():
					var str_state = states_debug_names[state]
					if next_states == "":
						next_states = str_state
					else:
						next_states = "%s, %s" % [next_states, str_state]
				print("Possible Next States: %s" % [next_states])
				print("\nEvery State:\n")
				for state in states_debug_names.keys():
					print('\t- %s' % states_debug_names[state])
				print('===============================================================================')
