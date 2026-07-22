extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0

@onready var hitbox = $Hitbox

func _ready() -> void:
	hitbox.body_entered.connect(body_entered)

func body_entered(body):
	queue_free()

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
	
