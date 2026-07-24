extends AnimatedSprite2D

@onready var col_shape = $Area2D/CollisionShape2D
var tile_layers: Array[TileMapLayer]

func _ready() -> void:
	speed_scale = randf_range(0.7, 1.3)
	flip_h = randi_range(0,1)==0
	play("default")

func _process(_delta) -> void:
	col_shape.disabled = true if frame < 6 else false
	
	if frame > 5:
		for tile_layer in tile_layers:
			var tile_at_cloud_level = tile_layer.local_to_map(Vector2(global_position.x, global_position.y))
			tile_layer.set_cell(tile_at_cloud_level, 0)
