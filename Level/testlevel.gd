extends Node2D

func _ready() -> void:
	AudioManager.play_song(AudioManager.Songs.MAIN_MENU)
