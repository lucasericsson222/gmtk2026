extends Node2D

@onready var timer = $Timer


var summon_position = 8
var number = 18
@onready var flame_scene = preload("res://Flame/Flame.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_timeout() -> void:
	for current in range(number):
		var flame_instance = flame_scene.instantiate()
		flame_instance.position = Vector2(8 + current * 16, summon_position)
		add_child(flame_instance)
	summon_position = summon_position + 16
