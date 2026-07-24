extends Node2D
class_name FlameSpark

@export var tile_map_layer: TileMapLayer
@export var flame_wall: FlameWall
@onready var flame_scene = preload("res://Flame/Flame.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if flame_wall.summon_position + flame_wall.position.y > global_position.y:
		var flame_instance: Flame = flame_scene.instantiate()
		flame_instance.position = position
		get_parent().add_child(flame_instance)
		flame_instance.tile_layers = [tile_map_layer]
		flame_instance.offset = Vector2(8,8)
		queue_free()
