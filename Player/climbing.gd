extends State
class_name ClimbingState

@export var player: CharacterBody2D


const CLIMB_SPEED: float = 100.0
func _enter() -> void:
	player.velocity = Vector2.ZERO

func _process(_delta) -> void:
	var dir = Input.get_axis("up", "down")
	player.velocity.y = CLIMB_SPEED * dir
	if Input.is_action_just_released("climb"):
		transition.emit(WalkingState)
	if Input.is_action_just_pressed("jump"):
		player.velocity = -player.JUMP_VELOCITY * (player.get_wall_normal() + Vector2(0, -2)).normalized()
		transition.emit(WalkingState)
	if not player.is_on_wall():
		transition.emit(WalkingState)
