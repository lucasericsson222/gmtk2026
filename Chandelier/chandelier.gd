extends RigidBody2D

@onready var ray_cast_2d = $RayCast2D
@onready var rope_segment = preload("res://Chandelier/RopeSegment/RopeSegment.tscn")
@onready var rope_end = preload("res://Chandelier/RopeSegment/RopeEnd.tscn")


func _physics_process(delta: float) -> void:
	if ray_cast_2d:
		if ray_cast_2d.is_colliding():
			var collider = ray_cast_2d.get_collider()
			var col_point = ray_cast_2d.get_collision_point()
			var cur_pos_offset = Vector2(0, 0)
			var target_position = col_point - ray_cast_2d.global_position
			
			var segments = []
			while cur_pos_offset.y > target_position.y:
				var segment = rope_segment.instantiate()
				add_child(segment)
				segments.append(segment)
				
				segment.position = ray_cast_2d.position + cur_pos_offset
				cur_pos_offset.y -= 3
			
			for i in range(len(segments)):
				var joint: PinJoint2D = segments[i].get_child(2)
				if i == 0:
					joint.node_a = self.get_path()
				else:
					joint.node_a = segments[i - 1].get_path()
				var end = rope_end.instantiate()
				add_child(end)
				end.position = ray_cast_2d.position + cur_pos_offset
				end.get_child(1).node_a = segments[i - 1].get_path()
			
			ray_cast_2d.queue_free()
