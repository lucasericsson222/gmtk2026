extends State
class_name DashingState

@onready var dash_timer = $DashTimer
@export var player: CharacterBody2D
@export var animation_tree: AnimationTree
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var falling_sprite: Sprite2D
@onready var particles: CPUParticles2D = $CPUParticles2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dash_timer.timeout.connect(_timeout)
	super._ready()
var saved_velocity
func _timeout():
	player.velocity.y = saved_velocity
	set_velocity = false
	transition.emit(WalkingState)

func _enter():
	dash_timer.start()
	animation_tree.active = false
	animation_player.play("dash")
	sprite.visible = true
	falling_sprite.visible = false
	particles.emitting = true

func _leave():
	animation_tree.active = true
	particles.emitting = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
var set_velocity = false
func _process(delta: float) -> void:
	particles.position = player.position
	if not set_velocity:
		saved_velocity = player.velocity.y
		player.velocity.y = 600
		set_velocity = true
		player.velocity.x = 0
	
