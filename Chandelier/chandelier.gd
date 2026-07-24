extends Node2D

@onready var ray_cast_2d = $RayCast2D
#@onready var rope_segment = preload("res://Chandelier/RopeSegment/RopeSegment.tscn")
@onready var rope_end = preload("res://Chandelier/RopeSegment/RopeEnd.tscn")
@onready var chandelier = $ChandelierRigidBody
@onready var line_2d = $ChandelierRigidBody/Line2D
#const SEGMENT_LENGTH = 8

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

		# START LINE IMPLEMENTATION
		line_2d.add_point(target_position + ray_cast_2d.position)
		var end = rope_end.instantiate()
		end.position = target_position + ray_cast_2d.position
		add_child(end)
		connect_pin(end.position, chandelier.get_path(), end.get_path())
		
		# START SEGMENT IMPLEMENTATION
		#var segments: Array[Node2D] = []
		#while cur_pos_offset.y > target_position.y:
			#var segment = rope_segment.instantiate()
			#segments.append(segment)
			#segment.position = ray_cast_2d.position + cur_pos_offset
			#add_child(segment)
			#cur_pos_offset.y -= SEGMENT_LENGTH
			#
		#var end = rope_end.instantiate()
		#end.position = ray_cast_2d.position + cur_pos_offset
		#segments.append(end)
		#add_child(end)
		#
		#for i in range(len(segments)):
			#if i == 0:
				#connect_pin(segments[i].position, chandelier.get_path(), segments[i].get_path())
			#else:
				#connect_pin(segments[i].position, segments[i - 1].get_path(), segments[i].get_path())
		
		ray_cast_2d.queue_free()
