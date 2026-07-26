extends Node2D

@onready var ray_cast_2d = $RayCast2D
@onready var chandelier = $ChandelierRigidBody
@onready var line_2d = $ChandelierRigidBody/Line2D
@onready var joint: PinJoint2D = PinJoint2D.new()

func connect_pin(pos: Vector2, node_a: NodePath, node_b: NodePath) -> void:
	joint.position = pos
	joint.node_a = node_a
	joint.node_b = node_b
	add_child(joint)

func _ready() -> void:
	$Area2D.area_entered.connect(_body_entered)
	$RopeArea.area_entered.connect(_rope_flame_entered)
	
func _body_entered(area: Area2D):
	if area.get_collision_layer_value(8):
		match randi_range(1, 3):
			1:
				AudioManager.play_sfx(AudioManager.SoundEffects.CHANDELIER)
			2:
				AudioManager.play_sfx(AudioManager.SoundEffects.CHANDELIER2)
			3:
				AudioManager.play_sfx(AudioManager.SoundEffects.CHANDELIER3)
	else:
		queue_free()
	
func _rope_flame_entered(area):
	$RopeArea.queue_free()
	line_2d.queue_free()
	joint.queue_free()


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
		$RopeArea.position = target_position
