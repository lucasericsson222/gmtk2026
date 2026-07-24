extends Node2D

@onready var timer = $Timer


var summon_position = 8
var number = 18
@onready var screen_size = get_viewport_rect().size

@onready var flame_scene = preload("res://Flame/Flame.tscn")
@export var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player:
		if player.position.y - summon_position > screen_size.y / 2:
			timer.wait_time = 0.05
			print("HI")
		else:
			timer.wait_time = 0.3
	else:
		timer.wait_time = 0.05

func _on_timeout() -> void:
	for current in range(number):
		var flame_instance = flame_scene.instantiate()
		flame_instance.position = Vector2(8 + current * 16, summon_position)
		add_child(flame_instance)
	summon_position = summon_position + 16
