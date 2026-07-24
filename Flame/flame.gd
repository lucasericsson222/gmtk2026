extends AnimatedSprite2D
class_name Flame
@onready var col_shape = $Area2D/CollisionShape2D
var tile_layers: Array[TileMapLayer]

func _ready() -> void:
	speed_scale = randf_range(0.7, 1.3)
	flip_h = randi_range(0,1)==0
	play("default")
	animation_finished.connect(_animation_finished)

func _animation_finished():
	queue_free()
	
func _process(_delta) -> void:
	col_shape.disabled = true if frame < 6 else false
	
	if frame > 5:
		for tile_layer in tile_layers:
			var burn_position = global_position - tile_layer.global_position
			var tile_at_cloud_level = tile_layer.local_to_map(burn_position)
			tile_layer.erase_cell(tile_at_cloud_level)
