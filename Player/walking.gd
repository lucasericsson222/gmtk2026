extends State
class_name WalkingState

@export var player: CharacterBody2D
@export var climb_area: Area2D
@export var climb_area_col: CollisionShape2D
@export var climb_timer: Timer
@export var animated_sprite: AnimatedSprite2D
const FRICTION: float = 100
const STRONG_FRICTION: float = 2000
const WALL_FRICTION: float = 3000
const MAX_WALL_FALL_SPEED: float = 100
const TERMINAL_VELOCITY: float = 500
var allow_climb: bool = false

func _ready() -> void:
	climb_timer.timeout.connect(climb_timeout)
	animated_sprite.play("walking")

func _enter() -> void:
	climb_timer.start()
	allow_climb = false

func _physics_process(delta: float) -> void:
	if player:
		if not player.is_on_floor():
			var gravity_modifier: float = 1.25
			if Input.is_action_pressed("jump"):
				gravity_modifier = 1.3
			else:
				gravity_modifier = 2.5
			if player.velocity.y > 0:
				if player.is_on_wall() and Input.get_axis("left", "right") == -player.get_wall_normal().x:
					if player.velocity.y > MAX_WALL_FALL_SPEED:
						player.velocity.y -= WALL_FRICTION * delta
					gravity_modifier = 0.5
				else:
					gravity_modifier = 2.5
			if player.velocity.y > TERMINAL_VELOCITY:
				player.velocity.y = TERMINAL_VELOCITY
			player.velocity += player.get_gravity() * gravity_modifier * delta

		if allow_climb and Input.is_action_pressed("climb") and climb_area.has_overlapping_bodies():
			player.move_and_collide(100 * climb_area_col.position * delta)
			transition.emit(ClimbingState)
		if Input.is_action_just_pressed("jump") and player.is_on_floor():
			player.velocity.y = player.JUMP_VELOCITY
		elif Input.is_action_just_pressed("jump") and player.is_on_wall():
			player.velocity = -player.JUMP_VELOCITY * (player.get_wall_normal() + Vector2(0, -1)).normalized()
		var direction := Input.get_axis("left", "right")
		
		if direction != 0:
			climb_area_col.position.x = 4 * direction
		
		if abs(player.velocity.x) < player.MAX_SPEED or direction != sign(player.velocity.x):
			player.velocity.x += direction * player.ACCEL_SPEED * delta
		
		if Input.is_action_pressed("left"):
			animated_sprite.flip_h = true
		if Input.is_action_pressed("right"):
			animated_sprite.flip_h = false
		
		if player.is_on_floor():
			animated_sprite.play("walking")
			var friction = FRICTION
			if direction != sign(player.velocity.x):
				friction = STRONG_FRICTION
			player.velocity.x -= sign(player.velocity.x) * min(abs(player.velocity.x), friction * delta)
		if direction == 0.0:
			animated_sprite.play("stand")
			

func climb_timeout() -> void:
	allow_climb = true
