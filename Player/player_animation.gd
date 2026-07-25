extends Node2D
#
#@export var player: CharacterBody2D
#@export var sprite: Sprite2D
#@export var falling_sprite: Sprite2D
#@export var animation_tree: AnimationTree
#
#func _physics_process(delta: float) -> void:
	#var direction = player.velocity.x
	#if direction:
		#sprite.flip_h = direction < 0
		#falling_sprite.flip_h = direction < 0
	#
	## TODO: change this to a signal
	#if Input.is_action_just_pressed("jump"):
		#animation_tree.set("parameters/conditions/is_start_jump", true)
	#else:
		#animation_tree.set("parameters/conditions/is_start_jump", false)
	#
	## TODO: This is wrong
	#if player.velocity.y > 0:
		#sprite.visible = false
		#falling_sprite.visible = true
	#else:
		#sprite.visible = true
		#falling_sprite.visible = false
