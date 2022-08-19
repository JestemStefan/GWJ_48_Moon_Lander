extends Node


var menu_player: AudioStreamPlayer
var level_player: AudioStreamPlayer

onready var menu_music: AudioStreamSample = preload("res://sound/music/To the Moon.wav")
onready var level_music: AudioStreamSample = preload("res://sound/music/Hordes and Hordes.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	play_main_menu_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_main_menu_music():
	stop_level_music()
	menu_player = AudioStreamPlayer.new()
	add_child(menu_player)
	menu_player.stream = menu_music
	menu_player.play()

func stop_main_menu_music():
	if is_instance_valid(menu_player):
		menu_player.call_deferred("free")
		menu_player = null

func play_level_music():
	stop_main_menu_music()
	level_player = AudioStreamPlayer.new()
	add_child(level_player)
	level_player.stream = level_music
	level_player.play()

func stop_level_music():
	if is_instance_valid(level_player):
		level_player.call_deferred("free")
		level_player = null
