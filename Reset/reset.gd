extends Node2D

@onready var player_scene: PackedScene = load("uid://c3fupar2gufir")
@export var camera: Camera
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		#var instance = player_scene.instantiate()
		#instance.position = position
		#get_parent().add_child(instance)
		#camera.target_scene = instance
		get_tree().reload_current_scene()
