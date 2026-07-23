extends Node
class_name State

signal _transition(new_state)

func _enter() -> void:
	pass

func _leave() -> void:
	pass

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
