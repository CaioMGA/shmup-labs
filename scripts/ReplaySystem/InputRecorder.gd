extends Node
var actions = ["up", "down", "right", "left", "focus", "bomb"]
var cur_frame = 0

@export var input_history = []
@export var is_recording = false

func start_recording():
	is_recording = true
	cur_frame = 0
	
func stop_recording():
	is_recording = false

func _process(_delta):
	if is_recording:
		cur_frame += 1
		for action in actions:
			if Input.is_action_just_pressed(action):
				add_input_record(action, true)
			if Input.is_action_just_released(action):
				add_input_record(action, false)

func add_input_record(action:String, pressed:bool):
	var action_event = "pressed" if pressed else "released"
	input_history.append({"frame":cur_frame, "action":action, "event":action_event})

func save_json():
	print("try to save json...")
	var save_path = "res://Replays/replay.save"
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(input_history)
	print("Save Complete!")
