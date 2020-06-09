extends KinematicBody2D

#signals emitted
signal attack
signal health_changed
signal attack_cooldown

enum {
	MOVE, ATTACK, ROLL, DAMAGE, DEATH
}

# Scene Config
export (int) var max_acceleration
export (int) var  max_speed
export (int) var friction
export (int) var health
export (int) var attack_cooldown
export (float) var attack_range
export (float) var damage
export (float) var knockback
export (PackedScene) var damage_info

# vars
var state = MOVE
var velocity = Vector2.ZERO
var death = false
var hitbox_size


func _physics_process(delta):
	control(delta)
	velocity = move_and_slide(velocity)
	
func control(delta):
	pass

func death():
	pass
	
func attack():
	pass
	
func config_hitbox():
	pass
