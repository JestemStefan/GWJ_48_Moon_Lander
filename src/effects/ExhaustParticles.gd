extends Node2D

onready var l_paticles = $L_Exhaust
onready var r_paticles = $R_Exhaust

func _ready():
	l_paticles.emitting = false
	r_paticles.emitting = false


func start_emitting():
	l_paticles.emitting = true
	r_paticles.emitting = true
	
func stop_emitting():
	l_paticles.emitting = false
	r_paticles.emitting = false
