extends Node
class_name StateMachine

@export var initial_state: State
var current_state: State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = initial_state
	current_state.process_mode = Node.PROCESS_MODE_INHERIT
	
	for child in get_children():
		child.connect("_transition", _transition)

func _transition(new_state):
	current_state._leave()
	current_state.process_mode = Node.PROCESS_MODE_DISABLED
	new_state.process_mode = Node.PROCESS_MODE_INHERIT
	current_state = new_state
	current_state._enter()
	
	
