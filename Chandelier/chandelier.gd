extends RigidBody2D

const RAY_LENGTH = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var space_state: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var cast = PhysicsRayQueryParameters2D.create(Vector2(0, 0), Vector2(0, 1000), 1)
	var result = space_state.intersect_ray(cast)
	print(result)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
