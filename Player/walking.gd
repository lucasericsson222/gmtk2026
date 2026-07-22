extends State

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if player:
		if not player.is_on_floor():
			player.velocity += player.get_gravity() * delta

		if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
			player.velocity.y = player.JUMP_VELOCITY

		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			player.velocity.x = direction * player.SPEED
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
