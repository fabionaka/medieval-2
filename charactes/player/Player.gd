extends "res://charactes/base.gd"

export (int) var max_dash_speed

var dashed = false;
var started_velocity = Vector2.ZERO

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
		animationTree.set("parameters/Dash/blend_position", input_vector)
		animationState.travel("Move")
	else : 
		velocity = velocity.move_toward(Vector2.ZERO, delta * friction)
		animationState.travel("Idle")
		
	# states change
	if Input.is_action_just_pressed("dash"):
		started_velocity = velocity
		state = DASH
	if Input.is_action_just_pressed("attack"):
		started_velocity = velocity
		state = ATTACK
		
	if Input.is_action_just_pressed("ui_up"):
		state = DAMAGE
	if Input.is_action_just_pressed("ui_down"):
		state = DEATH
		

func dash_state(delta):
	animationState.travel("Dash")
	if !dashed:
		velocity = velocity * (max_dash_speed * delta)
		dashed = true
	
func finish_dash_state():
	velocity = started_velocity
	state = MOVE
	dashed = false
	$EffectSprite.hide()

func finish_damage_state():
	print(velocity)
	state = MOVE
	dashed = false

func damage_state(delta):
	animationState.travel("KnockBack")
	if !dashed:
		velocity = velocity / knockback
		velocity = velocity * -1
		dashed = true
		
func death_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Death")
	
func destroy():
	queue_free()

func take_damage(damage, type):
	# modificadores de dano
	# diminuição de ponto e diminuoção de %
	health -= damage
	emit_signal("health_changed", health, damage)
	state = DAMAGE
