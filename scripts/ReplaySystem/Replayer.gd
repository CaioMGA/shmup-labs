extends Node

@export var input_history = []
@export var is_playing = false
@export var player:Node

const actions = ["up", "down", "right", "left", "focus", "bomb"]

var cur_frame = 0
var cur_input_entry = 0;
var next_action:Dictionary

# input flags
var up_pressed = false
var down_pressed = false
var right_pressed = false
var left_pressed = false
var focus_pressed = false
var bomb_pressed = false

func play():
	is_playing = true
	cur_frame = 0
	cur_input_entry = 0
	next_action = get_next_action()

func _process(_delta):
	if !is_playing: #if is not playing exit
		return
		
	while(next_action.frame == cur_frame && is_playing):
		if next_action.action == "up":
			up_pressed = next_action.event == "pressed"
		if next_action.action == "down":
			down_pressed = next_action.event == "pressed"
		if next_action.action == "right":
			right_pressed = next_action.event == "pressed"
		if next_action.action == "left":
			left_pressed = next_action.event == "pressed"
		
		next_action = get_next_action()
	
	update_player()
	cur_frame += 1
	

func update_player():
	if up_pressed :
		player.move_up()
	if down_pressed :
		player.move_down()
	if right_pressed :
		player.move_right()
	if left_pressed :
		player.move_left()

func get_next_action():
	cur_input_entry += 1
	if cur_input_entry >= input_history.size():
		is_playing = false
		return {"frame":0}
		
	return input_history[cur_input_entry]

func load_json():
	var save_path = "res://Replays/replay.save"
	if FileAccess.file_exists(save_path):
		print("file found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		input_history = file.get_var()
	else:
		print("No replays Found")

