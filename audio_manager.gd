extends Node

@onready var sfxStreams = $SFXStreams

enum SoundEffects {
	JUMP,
	WALL_JUMP,
	SPIKE,
	CHANDELIER,
	CHANDELIER2,
	CHANDELIER3
}

enum Songs {
	MAIN_MENU,
	LEVEL_THEME
}

const SFX_RESOURCES := {
	SoundEffects.JUMP: preload("res://Player/jump.wav"),
	SoundEffects.WALL_JUMP: preload("res://Player/wall_jump.wav"),
	SoundEffects.SPIKE: preload("res://Player/spike.wav"),
	SoundEffects.CHANDELIER: preload("res://Chandelier/chandelier.wav"),
	SoundEffects.CHANDELIER2: preload("res://Chandelier/chandelier2.wav"),
	SoundEffects.CHANDELIER3: preload("res://Chandelier/chandelier3.wav")
}

const SONG_RESOURCES := {
	Songs.MAIN_MENU: preload("res://Level/vampfyr_title_screen.mp3"),
	Songs.LEVEL_THEME: preload("res://Level/vampfyr_final.mp3")
}


func play_sfx(sfx: SoundEffects):
	for audioStreamPlayer in sfxStreams.get_children():
		if not audioStreamPlayer.is_playing():
			audioStreamPlayer.stream = SFX_RESOURCES[sfx]
			audioStreamPlayer.play()
			break

func play_song(song: Songs):
	$Music.stop()
	$Music.stream = SONG_RESOURCES[song]
	$Music.play()

func set_music_volume(db: float):
	$Music.volume_db = db
