extends Node

@onready var sfxStreams = $SFXStreams

enum SoundEffects {
	JUMP,
	WALL_JUMP,
	SPIKE
}

#enum Songs {
	#MAIN_MENU,
	#LEVEL_THEME
#}

const SFX_RESOURCES := {
	SoundEffects.JUMP: preload("res://Player/jump.wav"),
	SoundEffects.WALL_JUMP: preload("res://Player/wall_jump.wav"),
	SoundEffects.SPIKE: preload("res://Player/spike.wav"),
}

#const SONG_RESOURCES := {
	#Songs.MAIN_MENU: preload("res://main_menu/main_menu.mp3"),
	#Songs.LEVEL_THEME: preload("res://levels/level_theme.mp3")
#}


func play_sfx(sfx: SoundEffects):
	for audioStreamPlayer in sfxStreams.get_children():
		if not audioStreamPlayer.is_playing():
			audioStreamPlayer.stream = SFX_RESOURCES[sfx]
			audioStreamPlayer.play()
			break

#func play_song(song: Songs):
	#$Music.stop()
	#$Music.stream = SONG_RESOURCES[song]
	#$Music.play()
