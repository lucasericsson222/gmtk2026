extends Node


@export var start_free_list: Array[Node]
@export var player: CharacterBody2D
@export var flame_wall: FlameWall



func _input(event):
	if event is InputEventKey and event.pressed:
		AudioManager.set_music_volume(-3.0)
		AudioManager.play_song(AudioManager.Songs.LEVEL_THEME)
		for node in start_free_list:
			node.queue_free()
		flame_wall.process_mode = Node.PROCESS_MODE_INHERIT
		player.process_mode = Node.PROCESS_MODE_INHERIT
		queue_free()
