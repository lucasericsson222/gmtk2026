extends Camera2D
class_name Camera

@export var target_scene: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if target_scene:
		position.y = max(target_scene.position.y, 180)
