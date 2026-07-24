extends Node2D

@export var tile_map_layer: TileMapLayer
@export var flame_wall: FlameWall
@onready var spark_scene = preload("res://Flame/FlameSpark.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for coord in tile_map_layer.get_used_cells():
		var local = tile_map_layer.map_to_local(coord)
		local += tile_map_layer.global_position
		var spark_instance: FlameSpark = spark_scene.instantiate()
		spark_instance.global_position = local
		spark_instance.tile_map_layer = tile_map_layer
		spark_instance.flame_wall = flame_wall
		add_child(spark_instance)
