extends State
class_name ClimbingState

@export var player: CharacterBody2D
@export var climb_area: Area2D
@export var animated_sprite: AnimatedSprite2D
var left_wall: bool
const CLIMB_SPEED: float = 100.0
func _enter() -> void:
	player.velocity = Vector2.ZERO
	animated_sprite.play("walking")
	left_wall = animated_sprite.flip_h
	player.rotate(PI / 2 if left_wall else -PI/2)

func _process(_delta) -> void:
	var dir = Input.get_axis("up", "down")
	player.velocity.y = CLIMB_SPEED * dir
	animated_sprite.play("walking")
	if dir == 0.0:
		animated_sprite.play("stand")
	if left_wall:
		if Input.is_action_pressed("up"):
			animated_sprite.flip_h = true
		if Input.is_action_pressed("down"):
			animated_sprite.flip_h = false
	else:
		if Input.is_action_pressed("up"):
			animated_sprite.flip_h = false
		if Input.is_action_pressed("down"):
			animated_sprite.flip_h = true

	if Input.is_action_just_released("climb"):
		transition.emit(WalkingState)
	if Input.is_action_just_pressed("jump"):
		player.velocity = -player.JUMP_VELOCITY * (player.get_wall_normal() + Vector2(0, -2)).normalized()
		transition.emit(WalkingState)
	if not climb_area.has_overlapping_bodies():
		transition.emit(WalkingState)

func _leave() -> void:
	player.rotation = 0
