extends Node2D

onready var sfx_confetti: AudioStreamSample = preload("res://sound/sfx/GWJ_Congrats.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	play_once()


func play_once():
	$AudioStreamPlayer.play()
	for ps in get_children():
		if ps is CPUParticles2D:
			if (ps as CPUParticles2D).emitting == false:
				(ps as CPUParticles2D).emitting = true

