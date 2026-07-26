extends Area2D

var target: CharacterBody2D = null
var start_position: Vector2
var t = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	target = body
	start_position = target.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		target.velocity = Vector2.ZERO
		t += 1
		
		target.position = lerp(start_position, position, min(0.01 * t, 1))
		if (target.position - position).length() < 10:
			target.queue_free()
			target = null
