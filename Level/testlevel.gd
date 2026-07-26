extends Node2D

func _ready() -> void:
	AudioManager.set_music_volume(-6.0)
	AudioManager.play_song(AudioManager.Songs.MAIN_MENU)
