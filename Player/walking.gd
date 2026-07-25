extends State
class_name WalkingState

@export var player: CharacterBody2D
@export var sprite: Sprite2D
@export var falling_sprite: Sprite2D
@export var animation_tree: AnimationTree
@export var climb_area: Area2D
@export var climb_area_col: CollisionShape2D
@export var climb_timer: Timer
@export var walking_dust: GPUParticles2D
@export var sliding_dust: GPUParticles2D
const FRICTION: float = 100
const STRONG_FRICTION: float = 2000
const WALL_FRICTION: float = 3000
const MAX_WALL_FALL_SPEED: float = 100
var TERMINAL_VELOCITY: float = 500
var allow_climb: bool = false

func _ready() -> void:
	climb_timer.timeout.connect(climb_timeout)

func _enter() -> void:
	climb_timer.start()
	allow_climb = false
	
var frames_since_last_on_floor = 0

func _physics_process(delta: float) -> void:
	if player:
		handle_anim()
		if Input.is_action_just_pressed("dash"):
			transition.emit(DashingState)
		if not player.is_on_floor():
			var gravity_modifier: float = 1.25
			if Input.is_action_pressed("jump"):
				gravity_modifier = 1.3
				TERMINAL_VELOCITY = 50
			else:
				gravity_modifier = 2.5
				TERMINAL_VELOCITY = 500
			if player.velocity.y > 0:
				if player.is_on_wall() and Input.get_axis("left", "right") == -player.get_wall_normal().x:
					if player.velocity.y > MAX_WALL_FALL_SPEED:
						player.velocity.y -= WALL_FRICTION * delta
					gravity_modifier = 0.5
					sliding_dust.emitting = true
				else:
					gravity_modifier = 2.5
					sliding_dust.emitting = false
			else:
				sliding_dust.emitting = false
			if player.velocity.y > TERMINAL_VELOCITY:
				player.velocity.y = TERMINAL_VELOCITY
			player.velocity += player.get_gravity() * gravity_modifier * delta

		var direction := Input.get_axis("left", "right")
		if player.is_on_floor():
			frames_since_last_on_floor = 0
		else:
			frames_since_last_on_floor += 1

		if allow_climb and Input.is_action_pressed("climb") and climb_area.has_overlapping_bodies():
			player.move_and_collide(100 * climb_area_col.position * delta)
			sliding_dust.emitting = false
			transition.emit(ClimbingState)
		if Input.is_action_just_pressed("jump") and frames_since_last_on_floor < 5:
			frames_since_last_on_floor += 200
			player.velocity.y = player.JUMP_VELOCITY
		elif Input.is_action_just_pressed("jump") and player.is_on_wall():
			player.velocity = -player.JUMP_VELOCITY * (player.get_wall_normal() + Vector2(0, -1)).normalized()
		
		if direction != 0:
			climb_area_col.position.x = 4 * direction
		
		if player.velocity.x != 0 and player.is_on_floor():
			walking_dust.emitting = true
		else:
			walking_dust.emitting = false
		
		if abs(player.velocity.x) < player.MAX_SPEED or direction != sign(player.velocity.x):
			player.velocity.x += direction * player.ACCEL_SPEED * delta
		
		if player.is_on_floor():
			var friction = FRICTION
			if direction != sign(player.velocity.x):
				friction = STRONG_FRICTION
			player.velocity.x -= sign(player.velocity.x) * min(abs(player.velocity.x), friction * delta)			

func handle_anim() -> void:
	var direction = player.velocity.x
	if direction:
		sprite.flip_h = direction < 0
		falling_sprite.flip_h = direction < 0
	
	# TODO: change this to a signal
	if Input.is_action_just_pressed("jump"):
		animation_tree.set("parameters/conditions/is_start_jump", true)
	else:
		animation_tree.set("parameters/conditions/is_start_jump", false)
	
	# TODO: This is wrong
	if player.velocity.y > 0:
		sprite.visible = false
		falling_sprite.visible = true
	else:
		sprite.visible = true
		falling_sprite.visible = false

func climb_timeout() -> void:
	allow_climb = true
