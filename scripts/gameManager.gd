extends Node

var DEBUGGING_GAMESTATES = true

# Possible Game States
enum States {
	START,
	PLAYING,
	GAME_OVER,
	PAUSED,
	FINISHED,
	EXIT
}

var states_debug_names = {
	States.START: 'START (%s)' % States.START,
	States.PLAYING: 'PLAYING (%s)' % States.PLAYING,
	States.GAME_OVER: 'GAME_OVER (%s)' % States.GAME_OVER,
	States.PAUSED: 'PAUSED (%s)' % States.PAUSED,
	States.FINISHED: 'FINISHED (%s)' % States.FINISHED,
	States.EXIT: 'EXIT (%s)' % States.EXIT
}

# Starting state for the game
var current_state = States.START

# Dict saving unique possible next states
var possible_next_states = {
	States.START: {
		States.EXIT: _do_nothing,
		States.PLAYING: _do_nothing
	},
	States.PLAYING: {
		States.FINISHED: _do_nothing,
		States.GAME_OVER: _do_nothing,
		States.PAUSED: _do_nothing
	},
	States.GAME_OVER: {
		States.PLAYING: _do_nothing,
		States.EXIT: _do_nothing
	},
	States.FINISHED: {
		States.PLAYING: _do_nothing,
		States.EXIT: _do_nothing
	},
	States.PAUSED: {
		States.PLAYING: _do_nothing,
		States.EXIT: _do_nothing
	},
	States.EXIT: {}
}

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
	# change_state(States.START)
	pass
	
func _process(delta):
	pass

func _input(event):
	if DEBUGGING_GAMESTATES:
		if event is InputEventKey and event.pressed:
			if event.keycode == KEY_0:
				change_state(States.START)
			if event.keycode == KEY_1:
				change_state(States.PLAYING)
			if event.keycode == KEY_2:
				change_state(States.GAME_OVER)
			if event.keycode == KEY_3:
				change_state(States.PAUSED)
			if event.keycode == KEY_4:
				change_state(States.FINISHED)
			if event.keycode == KEY_5:
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
