extends Node2D
class_name FlameSpark

@export var tile_map_layer: TileMapLayer
@export var flame_wall: FlameWall
@onready var flame_scene = preload("res://Flame/Flame.tscn")
@onready var timer: Timer = $Timer

@onready var flame_spark_scene = preload("res://Flame/FlameSpark.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timeout)

func _on_timeout() -> void:
	for offset in [Vector2(-16, 0), Vector2(16,0), Vector2(0,16), Vector2(0,-16)]:
		var new_pos: Vector2i = position + offset
		var rel_pos: Vector2i = global_position + offset - tile_map_layer.global_position
		var new_coord = tile_map_layer.local_to_map(rel_pos)
		if not tile_map_layer.get_cell_tile_data(new_coord):
			continue
		var raycast = RayCast2D.new()
		raycast.position = Vector2(8,8)
		raycast.target_position = offset
		raycast.add_exception($Area2D)
		add_child(raycast)
		raycast.collide_with_bodies = false
		raycast.collide_with_areas = true
		raycast.hit_from_inside = true
		raycast.set_collision_mask_value(1, false)
		raycast.set_collision_mask_value(2, false)
		raycast.set_collision_mask_value(3, false)
		raycast.set_collision_mask_value(4, false)
		raycast.set_collision_mask_value(5, true)
		raycast.force_raycast_update()
		if raycast.is_colliding():
			continue
		raycast.queue_free()
		var flame_spark_instance: FlameSpark = flame_spark_scene.instantiate()
		flame_spark_instance.position = new_pos
		flame_spark_instance.tile_map_layer = tile_map_layer
		flame_spark_instance.flame_wall = flame_wall
		get_parent().add_child(flame_spark_instance)
	
var burnt = false

func create_flame(pos: Vector2):
	var flame_instance: Flame = flame_scene.instantiate()
	flame_instance.position = pos
	get_parent().add_child(flame_instance)
	flame_instance.tile_layers = [tile_map_layer]
	flame_instance.offset = Vector2(8,8)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not burnt:
		if flame_wall.summon_position + flame_wall.position.y > global_position.y:
			create_flame(position)
			burnt = true
			timer.start()
