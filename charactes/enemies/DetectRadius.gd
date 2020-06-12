extends Area2D

var radius = 0

func _ready():
	
	radius = get_parent().detect_radius
	var detection_shape = CircleShape2D.new()
	detection_shape.radius = radius;
	$DetectRadiusShape.shape = detection_shape
	
