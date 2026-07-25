extends CharacterBody2D


const ACCEL_SPEED = 1200.0
const MAX_SPEED = 200.0
const JUMP_VELOCITY = -250.0

@onready var hitbox = $Hitbox

func _ready() -> void:
	hitbox.body_entered.connect(body_entered)
	hitbox.area_entered.connect(body_entered)

func body_entered(body):
	if is_instance_of(body, TileMapLayer):
		AudioManager.play_sfx(AudioManager.SoundEffects.SPIKE)
	else:
		#AudioManager.play_sfx(AudioManager.SoundEffects.FIRE_DEATH)
		pass
	queue_free()

func _physics_process(_delta: float) -> void:
	move_and_slide()
