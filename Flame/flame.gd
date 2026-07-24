extends AnimatedSprite2D

@onready var col_shape = $Area2D/CollisionShape2D

func _ready() -> void:
	speed_scale = randf_range(0.7, 1.3)
	flip_h = randi_range(0,1)==0
	play("default")

func _process(_delta) -> void:
	col_shape.disabled = true if frame < 6 else false
