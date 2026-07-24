extends Node2D

@onready var ray_cast_2d = $RayCast2D
@onready var chandelier = $ChandelierRigidBody
@onready var line_2d = $ChandelierRigidBody/Line2D

func connect_pin(pos: Vector2, node_a: NodePath, node_b: NodePath) -> void:
	var joint: PinJoint2D = PinJoint2D.new()
	joint.position = pos
	joint.node_a = node_a
	joint.node_b = node_b
	add_child(joint)

func _physics_process(_delta: float) -> void:
	if ray_cast_2d and ray_cast_2d.is_colliding():
		var col_point = ray_cast_2d.get_collision_point()
		var target_position = col_point - ray_cast_2d.global_position

		line_2d.add_point(target_position + ray_cast_2d.position)
		var end: StaticBody2D = StaticBody2D.new()
		end.position = target_position + ray_cast_2d.position
		add_child(end)
		connect_pin(end.position, chandelier.get_path(), end.get_path())
		
		ray_cast_2d.queue_free()
