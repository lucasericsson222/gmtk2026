extends State
class_name WalkingState

@export var player: CharacterBody2D

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
			player.velocity = player.JUMP_VELOCITY * (player.get_wall_normal() + Vector2(0, 1)).normalized()
			player.velocity.x *= -2
		var direction := Input.get_axis("left", "right")
		
		if direction != 0.0:
			if direction > 0.0:
				if player.velocity.x < player.SPEED:
					player.velocity.x += 8 * player.SPEED * delta
			else:
				if -player.velocity.x < player.SPEED:
					player.velocity.x -= 8 *player.SPEED * delta
		player.velocity.x -= 10 * delta * player.velocity.x
		
