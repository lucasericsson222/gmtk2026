extends Node
class_name State

signal transition(new_state)

func _ready() -> void:
	transition.connect(_transition)
	process_mode = Node.PROCESS_MODE_DISABLED
	
func _enter() -> void:
	pass

func _leave() -> void:
	pass
	
func _transition(new_state) -> void:
	pass
