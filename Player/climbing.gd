extends State
class_name ClimbingState

@export var player: CharacterBody2D
@export var climb_area: Area2D
@export var sprite: Sprite2D
@export var falling_sprite: Sprite2D
@export var animation_tree: AnimationTree
@export var collision_shape: CollisionShape2D
@export var walking_dust: GPUParticles2D

var left_wall: bool
const CLIMB_SPEED: float = 100.0
func _enter() -> void:
	player.velocity = Vector2.ZERO
	left_wall = sprite.flip_h
	player.rotate(PI / 2 if left_wall else -PI/2)
	collision_shape.position.y += 2
	
	var state_machine = animation_tree.get("parameters/playback")
	state_machine.start("stand")
	sprite.visible = true
	falling_sprite.visible = false

var climbing_release_frame_count: int = 0

func _physics_process(_delta) -> void:
	handle_anim()
	var dir = Input.get_axis("up", "down")
	player.velocity.y = CLIMB_SPEED * dir
	if dir == 0.0:
		walking_dust.emitting = false
	else:
		walking_dust.emitting = true


	if Input.is_action_just_released("climb"):
		transition.emit(WalkingState)
	if Input.is_action_just_pressed("jump"):
		player.velocity = player.JUMP_VELOCITY * (-player.get_wall_normal() + Vector2(0, 2)).normalized()
		player.velocity.y *= 1.4
		transition.emit(WalkingState)
	if not climb_area.has_overlapping_bodies():
		climbing_release_frame_count += 1
		if climbing_release_frame_count > 10:
			transition.emit(WalkingState)
	else:
		climbing_release_frame_count = 0

func _leave() -> void:
	player.rotation = 0
	collision_shape.position.y -= 2

func handle_anim() -> void:
	var direction = player.velocity.y
	if direction:
		sprite.flip_h = left_wall != (direction > 0)
	
	# TODO: change this to a signal
	if Input.is_action_just_pressed("jump"):
		animation_tree.set("parameters/conditions/is_start_jump", true)
	else:
		animation_tree.set("parameters/conditions/is_start_jump", false)
