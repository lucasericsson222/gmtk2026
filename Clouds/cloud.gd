extends AnimatedSprite2D

var velocity: Vector2 = Vector2.ZERO
@onready var screen_size = get_viewport_rect().size
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame = randi_range(0, 3)
	flip_h = randi_range(0,1) == 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position += velocity
	position.x = wrapf(position.x, 0 - 64*2, screen_size.x + 64*2)
