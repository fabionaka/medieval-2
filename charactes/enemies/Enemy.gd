extends "res://charactes/base.gd"

export (int) var wait_time

var target = null
var target_vector = Vector2.ZERO
var wait_timer = 0
var target_vector_auto = Vector2.ZERO
var tic = true

func _ready():
	add_to_group("enemies")



func _on_DetectRadius_body_entered(body):
	if body.get_collision_layer() == 1  && get_tree().get_nodes_in_group("player").count(body) == 1:
		target = body

func _on_DetectRadius_body_exited(body):
	if body == target: 
		target = null
		target_vector = Vector2.ZERO



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
	
	
	if target :
		target_vector = (target.global_position - global_position) * delta
		target_vector = target_vector.normalized()
	else :
		target_vector = move_random(delta)
	
	if target_vector != Vector2.ZERO :
		velocity = velocity.move_toward(target_vector * max_speed, max_acceleration * delta)
		animationTree.set("parameters/Idle/blend_position", target_vector)
		animationTree.set("parameters/Move/blend_position", target_vector)
		animationState.travel("Move")
	else :
		velocity = velocity.move_toward(Vector2.ZERO, delta * friction)
		animationState.travel("Idle")
		
	if Input.is_action_just_pressed("ui_up"):
		state = DAMAGE
	if Input.is_action_just_pressed("ui_down"):
		state = DEATH
		
func move_random(delta):
	if wait_timer == wait_time : 
		if tic: 
			var rngx = RandomNumberGenerator.new()
			var rngy = RandomNumberGenerator.new()
			rngx.randomize()
			rngy.randomize()
			target_vector_auto = Vector2(rngx.randf_range(-1,1), rngy.randf_range(-1,1)) /2 * delta
			target_vector_auto = target_vector_auto.normalized()
			tic = false
		else : 
			target_vector_auto = Vector2.ZERO
			tic = true
		wait_timer = 0
	else : 
		wait_timer += 1
	return target_vector_auto

func damage_state(delta):
	animationState.travel("KnockBack")
	velocity = Vector2.ZERO
	
func damage_state_end():
	state = MOVE
	
func death_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Death")
	
