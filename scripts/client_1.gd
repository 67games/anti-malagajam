extends Control

@onready var label = $Label
@onready var texture_rect_2 = $TextureRect2
@onready var next_char_timer = $NextChar

var initial_label_text
var initial_character_position

var typing_speed = .1
var read_time = 2

var display = ""
var current_char = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_character_position = texture_rect_2.position
	texture_rect_2.position.x = texture_rect_2.position.x + 200
	initial_label_text = label.text
	label.text = ''
	start_dialogue()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if texture_rect_2.position.x != initial_character_position.x:
		texture_rect_2.position.x -=1
		
	if Input.is_action_just_pressed("click"):
		GameManager.change_state(GameManager.States.PLAYING)

func start_dialogue():
	display = ""
	current_char = 0
	next_char_timer.start(typing_speed)

func stop_dialogue():
	# get_parent().remove_child(self)
	queue_free()

func _on_next_char_timeout():
	if (current_char < len(initial_label_text)):
		var next_char = initial_label_text[current_char]
		display += next_char
		
		label.text = display
		current_char += 1
	else:
		next_char_timer.stop()
