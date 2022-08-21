extends Node

var player: Player = null
var lastTime := 0.0
var lastFuel := 0
var maximumTime := 0.0
var minimumFuel := 0

onready var sfx_exposion: PackedScene = preload("res://scenes/SFX/Explosion.tscn")
onready var confetti_scene: PackedScene = preload("res://art/confetti/Confetti.tscn")

signal wonLevel
signal failedLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func landing(landing_velocity: float):
	if landing_velocity <= 10:
		self.goodLanding(1)
	
	elif landing_velocity < 25:
		self.goodLanding(0)
	
	else:
		self.failure_landing()
	
func goodLanding(baseScore: int) -> void:
	var score = baseScore
	
	if lastTime <= maximumTime:
		score += 1
	
	if lastFuel >= minimumFuel:
		score += 1 
	
	self._create_confetti()
	emit_signal("wonLevel", score)	

func failure_landing():
	self.create_explosion()
	player.call_deferred("free")
	emit_signal("failedLevel", "Lithobraking!")

func total_failure():
	self.create_explosion()
	player.call_deferred("free")
	emit_signal("failedLevel", "Oops...")

func create_explosion():
	var _exposion = sfx_exposion.instance()
	get_tree().current_scene.add_child(_exposion)
	_exposion.global_position = player.global_position
	_exposion.emitting = true

func _create_confetti():
	var _confetti = confetti_scene.instance()
	get_tree().current_scene.add_child(_confetti)
