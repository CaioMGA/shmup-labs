extends Node2D
var move_count = 0

var movement_actions = ["up", "down", "right", "left"]
var focus_action = "focus"
var bomb_action = "bomb"
var is_focus_mode = false

var base_speed = 4
var speed = 0
var focus_speed_multiplier = 0.5

func _ready():
	speed = base_speed

func _process(_delta):
	for action in movement_actions:
		if Input.is_action_pressed(action) || Input.is_action_just_pressed(action):
			solve_action(action)
	
	if Input.is_action_just_pressed(focus_action):
		focus_on()
	if Input.is_action_just_released(focus_action):
		focus_off()
		
	if Input.is_action_just_pressed(bomb_action):
		bomb()


func solve_action(action):
	if action == "up":
		move_up()
	if action == "down":
		move_down()
	if action == "right":
		move_right()
	if action == "left":
		move_left()


func move_up():
	position.y -= speed
	move_count += 1
func move_down():
	position.y += speed
	move_count += 1
func move_left():
	position.x -= speed
	move_count += 1
func move_right():
	position.x += speed
	move_count += 1
	
func focus_on():
	is_focus_mode = true
	speed = base_speed * focus_speed_multiplier
	modulate = modulate.darkened(0.5)
	# TODO: emit signal focus mode is on
	
func focus_off():
	is_focus_mode = false
	modulate = Color.WHITE
	speed = base_speed
	# TODO: emit signal focus mode is off

func bomb():
	#TODO: throws bomb if player has it
	pass

func _player_print():
	print("position = x:%f,\ty:%f\tspeed:%f" % [position.x, position.y, speed])
