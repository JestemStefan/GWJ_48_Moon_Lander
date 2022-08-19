extends Node

var player: Player = null

var UI: Control = null
onready var landing_result_label: PackedScene = preload("res://scenes/UI/LandingResultLabel.tscn")
onready var sfx_exposion: PackedScene = preload("res://scenes/SFX/Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func landing(landing_velocity: float):
	if landing_velocity <= 10:
		self.perfect_landing()
	
	elif landing_velocity < 25:
		self.good_landing()
	
	else:
		self.failure_landing()

func perfect_landing():
	var landing_label: Label = self._create_landing_popup()
	landing_label.text = "Perfect landing!"
	UI.level_finished()

func good_landing():
	var landing_label: Label = self._create_landing_popup()
	landing_label.text = "Nice landing!"
	UI.level_finished()

func failure_landing():
	var landing_label: Label = self._create_landing_popup()
	landing_label.text = "Lithobraking!"
	
	self.create_explosion()
	player.call_deferred("free")
	UI.level_finished()

func total_failure():
	var landing_label: Label = self._create_landing_popup()
	landing_label.text = "Ups..."
	
	self.create_explosion()
	player.call_deferred("free")
	UI.level_finished()

func _create_landing_popup():
	var _label = landing_result_label.instance()
	get_tree().current_scene.add_child(_label)
	_label.rect_global_position += player.global_position + Vector2(0, -100)
	return _label

func create_explosion():
	var _exposion = sfx_exposion.instance()
	get_tree().current_scene.add_child(_exposion)
	_exposion.global_position = player.global_position
	_exposion.emitting = true
