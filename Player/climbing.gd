extends State
class_name ClimbingState

@export var player: CharacterBody2D
@export var climb_area: Area2D
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var collision_shape: CollisionShape2D
@export var walking_dust: GPUParticles2D

var left_wall: bool
const CLIMB_SPEED: float = 100.0
func _enter() -> void:
	player.velocity = Vector2.ZERO
	animation_player.play("walk")
	left_wall = sprite.flip_h
	player.rotate(PI / 2 if left_wall else -PI/2)
	collision_shape.position.y += 2

func _process(_delta) -> void:
	var dir = Input.get_axis("up", "down")
	player.velocity.y = CLIMB_SPEED * dir
	animation_player.play("walk")
	if dir == 0.0:
		walking_dust.emitting = false
		animation_player.play("stand")
	else:
		walking_dust.emitting = true
	if left_wall:
		if Input.is_action_pressed("up"):
			sprite.flip_h = true
		if Input.is_action_pressed("down"):
			sprite.flip_h = false
	else:
		if Input.is_action_pressed("up"):
			sprite.flip_h = false
		if Input.is_action_pressed("down"):
			sprite.flip_h = true

	if Input.is_action_just_released("climb"):
		transition.emit(WalkingState)
	if Input.is_action_just_pressed("jump"):
		player.velocity = -player.JUMP_VELOCITY * (player.get_wall_normal() + Vector2(0, -2)).normalized()
		transition.emit(WalkingState)
	if not climb_area.has_overlapping_bodies():
		transition.emit(WalkingState)

func _leave() -> void:
	player.rotation = 0
	collision_shape.position.y -= 2
