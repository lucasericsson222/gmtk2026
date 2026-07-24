extends Node2D

var max_height = 3000
var num_clouds = 20
@onready var cloud_scene = preload("res://Clouds/Cloud.tscn")
@onready var screen_size = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(num_clouds):
		var cloud_instance = cloud_scene.instantiate()
		cloud_instance.position.y = randf_range(0, max_height)
		cloud_instance.position.x = randf_range(0, screen_size.x)
		cloud_instance.velocity = Vector2(randf_range(0.4,1), 0) * (randi_range(0,1) * 2 - 1)
		add_child(cloud_instance)
