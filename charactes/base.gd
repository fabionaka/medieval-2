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

onready var animationPlayer = $AnimationPlayer 
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true
	
	#AttackArea
	change_attack_area()
	
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
	
func change_attack_area():
	var shape = CircleShape2D.new()
	shape.radius = attack_range
	$AttackArea/AttackAreaShape.shape = shape
