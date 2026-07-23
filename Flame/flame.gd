extends AnimatedSprite2D


func _ready() -> void:
	speed_scale = randf_range(0.7, 1.3)
	play("default")
