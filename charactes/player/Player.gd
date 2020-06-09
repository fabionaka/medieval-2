extends "res://charactes/base.gd"


func _ready():
	pass

func control(delta):
	match state : 
		MOVE : 
			move_state(delta)
		ATTACK : 
			attack_state(delta)
		JUMP:
			jump_state(delta)
		DASH :
			dash_state(delta)
		DAMAGE :
			damage_state(delta)
		DEATH:
			death_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	
	# get input 
	input_vector = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).normalized()
	if input_vector !=  Vector2.ZERO :
		velocity = velocity.move_toward(input_vector * max_speed, max_acceleration * delta)
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Move/blend_position", input_vector)
		animationState.travel("Move")
	else : 
		velocity = velocity.move_toward(Vector2.ZERO, delta * friction)
		animationState.travel("Idle")
		
	# states change
	if Input.is_action_just_pressed("dash"):
		state = DASH
	if Input.is_action_just_pressed("attack"):
		state = ATTACK


