extends Node

var player: Player = null
var lastTime := 0
var lastFuel := 0
var minimumFuel := 0

onready var sfx_exposion: PackedScene = preload("res://scenes/SFX/Explosion.tscn")
onready var confetti_scene: PackedScene = preload("res://art/confetti/Confetti.tscn")

signal wonLevel
signal failedLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func landing(landing_velocity: float, landing_stars: int):
	if landing_velocity <= 10:
		self.goodLanding(landing_stars, true)
	
	elif landing_velocity < 25:
		self.goodLanding(landing_stars, false)
	
	else:
		self.failure_landing()
	
func goodLanding(landing_stars: int, velocity_low: bool) -> void:
	var enough_fuel = lastFuel >= minimumFuel
	
	self._create_confetti()
	emit_signal("wonLevel", landing_stars, velocity_low, enough_fuel, lastTime)	

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
