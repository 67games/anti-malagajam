extends Node

@export var DEBUGGING_GAMESTATES = true

# Possible Game States
enum States {
	# State of the game as it is starting
	BOOTING,
	# Start Menu of the game
	START,
	# Playing some level
	PLAYING,
	# When the player failed the game
	GAME_OVER,
	# When the game is paused
	PAUSED,
	# When the player has won the game
	FINISHED,
	# Exiting the game
	EXIT
}

var current_state: States = States.BOOTING

var states_debug_names = {
	States.BOOTING: 'BOOTING (%s)' % States.BOOTING,
	States.START: 'START (%s)' % States.START,
	States.PLAYING: 'PLAYING (%s)' % States.PLAYING,
	States.GAME_OVER: 'GAME_OVER (%s)' % States.GAME_OVER,
	States.PAUSED: 'PAUSED (%s)' % States.PAUSED,
	States.FINISHED: 'FINISHED (%s)' % States.FINISHED,
	States.EXIT: 'EXIT (%s)' % States.EXIT
}

# Dict saving unique possible next states
var possible_next_states = {
	States.BOOTING: {
		States.START: _from_booting_to_start
	},
	States.START: {
		States.EXIT: _exit,
		States.PLAYING: _from_start_to_playing
	},
	States.PLAYING: {
		States.FINISHED: _do_nothing,
		States.GAME_OVER: _do_nothing,
		States.PAUSED: _do_nothing
	},
	States.GAME_OVER: {
		States.PLAYING: _do_nothing,
		States.EXIT: _exit
	},
	States.FINISHED: {
		States.PLAYING: _do_nothing,
		States.EXIT: _exit
	},
	States.PAUSED: {
		States.PLAYING: _do_nothing,
		States.EXIT: _exit
	},
	States.EXIT: {}
}

func _from_booting_to_start():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _from_start_to_playing():
	get_tree().change_scene_to_file("res://scenes/gameplay.tscn")

func _exit():
	print_debug('Exiting game')
	get_tree().quit()

# Temporal function for game state changes that do nothing
func _do_nothing():
	pass

# Change State executing required functions
func change_state(new_state):
	print_debug("change_state from %s to %s" % [states_debug_names[current_state], states_debug_names[new_state]])
	assert(new_state in possible_next_states[current_state], 'Game state change was ilegal')
	possible_next_states[current_state][new_state].call()
	current_state = new_state

func _ready():
	# print(get_tree().get_current_scene().name)
	if get_tree().get_current_scene().name == 'MainGame':
		change_state(States.START)
	
func _process(delta):
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
