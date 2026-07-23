extends State
class_name WalkingState

@export var player: CharacterBody2D
const FRICTION: float = 100
const STRONG_FRICTION: float = 2000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if player:
		if not player.is_on_floor():
			var gravity_modifier: float = 1.25
			if Input.is_action_pressed("jump"):
				gravity_modifier = 1.3
			else:
				gravity_modifier = 2.5
			if player.velocity.y > 0:
				gravity_modifier = 2.5
			player.velocity += player.get_gravity() * gravity_modifier * delta

		if Input.is_action_pressed("climb") and player.is_on_wall():
			transition.emit(ClimbingState)
		if Input.is_action_just_pressed("jump") and player.is_on_floor():
			player.velocity.y = player.JUMP_VELOCITY
		elif Input.is_action_just_pressed("jump") and player.is_on_wall():
			player.velocity = -player.JUMP_VELOCITY * (player.get_wall_normal() + Vector2(0, -1)).normalized()
		var direction := Input.get_axis("left", "right")
		
		if abs(player.velocity.x) < player.MAX_SPEED or direction != sign(player.velocity.x):
			player.velocity.x += direction * player.ACCEL_SPEED * delta
		
		if player.is_on_floor():
			var friction = FRICTION
			if direction != sign(player.velocity.x):
				friction = STRONG_FRICTION
			player.velocity.x -= sign(player.velocity.x) * min(abs(player.velocity.x), friction * delta)
			
