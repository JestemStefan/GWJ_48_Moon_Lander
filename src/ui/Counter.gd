extends Control

onready var _timeLabel: Label = $VBoxContainer/TimeLabel
onready var _fuelLabel: Label = $VBoxContainer/FuelLabel

export var startFuel: int = 0

signal fuelEmpty()

var _currentFuel: int
var _startTicks: int

func _ready() -> void:
	_currentFuel = startFuel
	_startTicks = OS.get_ticks_msec()
	_setFuelLabel()

func _process(_delta: float) -> void:
	var ticks = OS.get_ticks_msec() - _startTicks
	GameManager.lastTime = ticks;
	
	var secs = ticks / 1000;
	var mins = secs / 60;
	secs = secs % 60;
	ticks = ticks % 1000;
	
	_timeLabel.text = String(mins).pad_zeros(2) + ":" + String(secs).pad_zeros(2) + "." + String(ticks).pad_zeros(3)
	
func decreaseFuel() -> void:
	if _currentFuel <= 0:
		emit_signal("fuelEmpty")
		pass
	_currentFuel -= 1;
	GameManager.lastFuel = _currentFuel
	_setFuelLabel()
	
func _setFuelLabel() -> void:
	_fuelLabel.text = "Fuel: " + String(_currentFuel).pad_zeros(4)
