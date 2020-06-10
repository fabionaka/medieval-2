extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite_size = get_parent().get_node("Sprite").get_rect().size
	var hit_shape = RectangleShape2D.new()
	hit_shape.set_extents(Vector2(sprite_size.x / 3, sprite_size.y / 2))
	$HitboxShape.shape = hit_shape
	position.y = position.y + 1
