extends Control

onready var stars := [
	$Panel/CenterContainer/VBoxContainer/StarContainer/Star1,
	$Panel/CenterContainer/VBoxContainer/StarContainer/Star2,
	$Panel/CenterContainer/VBoxContainer/StarContainer/Star3,
	$Panel/CenterContainer/VBoxContainer/StarContainer/Star4,
	$Panel/CenterContainer/VBoxContainer/StarContainer/Star5,
]

onready var fullTexture := preload("res://art/moon_full_star.png")
onready var successLabel: Label = $Panel/CenterContainer/VBoxContainer/SuccessLabel
onready var failureLabel: Label = $Panel/CenterContainer/VBoxContainer/FailureLabel
onready var timeLabel: Label = $Panel/CenterContainer/VBoxContainer/TimeLabel

onready var popup: Panel = $StarPopupPanel
onready var popupContainer: Control = $StarPopupPanel/StarPopupContainer
onready var popupEasyTarget: HBoxContainer = $StarPopupPanel/StarPopupContainer/VBoxContainer/EasyTarget
onready var popupMediumTarget: HBoxContainer = $StarPopupPanel/StarPopupContainer/VBoxContainer/MediumTarget
onready var popupHardTarget: HBoxContainer = $StarPopupPanel/StarPopupContainer/VBoxContainer/HardTarget
onready var popupFuel: HBoxContainer = $StarPopupPanel/StarPopupContainer/VBoxContainer/Fuel
onready var popupVelocity: HBoxContainer = $StarPopupPanel/StarPopupContainer/VBoxContainer/Velocity

export var minimumFuelForStar: int = 500

var won := false

func _ready():
	GameManager.connect("wonLevel", self, "wonLevel")
	GameManager.connect("failedLevel", self, "failedLevel")
	GameManager.minimumFuel = minimumFuelForStar
	popupFuel.get_node("Label").text = "Fuel >" + String(minimumFuelForStar)
	
func wonLevel(landingScore: int, velocityScore: bool, fuelScore: bool, time: int) -> void:
	var score = landingScore + int(velocityScore) + int(fuelScore)
	successLabel.visible = true
	won = true
	
	if landingScore > 2:
		popupHardTarget.visible = true
	elif landingScore > 1:
		popupMediumTarget.visible = true
	else:
		popupEasyTarget.visible = true
		
	popupVelocity.visible = velocityScore
	popupFuel.visible = fuelScore
	
	visible = true
	popupContainer.emit_signal("item_rect_changed")
	
	updateTime(time)
	showScore(score)

func showScore(score: int) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	
	for n in score:
		tween.tween_property(stars[n], "texture", fullTexture, 0.1)
		tween.tween_property(stars[n], "rect_scale", Vector2(2, 2), 0.1)
		tween.tween_property(stars[n], "rect_rotation", 360.0, 0.75)
		tween.parallel().tween_property(stars[n], "rect_scale", Vector2(1, 1), 0.75)
		tween.tween_interval(0.5)

func failedLevel(msg: String) -> void:
	failureLabel.visible = true
	failureLabel.text = msg
	updateTime(GameManager.lastTime)
	visible = true

func updateTime(ticks: int) -> void:
	var secs = ticks / 1000
	var mins = secs / 60
	secs = secs % 60
	timeLabel.text = String(mins).pad_zeros(2) + ":" + String(secs).pad_zeros(2) + "." + String(ticks % 1000).pad_zeros(3)

func onRestartButtonPressed():
	$ClickSFX.play()
	get_tree().reload_current_scene()

func onBackToLevelSelectButtonPressed():
	$ClickSFX.play()
	MusicManager.play_main_menu_music()
	get_tree().change_scene("res://scenes/menu/LevelSelection.tscn")

func onRestartMouseEntered():
	$HoverSFX.play()

func onBackToLevelSelectMouseEntered():
	$HoverSFX.play()

func onStarContainerMouseEntered():
	if won:
		popupContainer.emit_signal("item_rect_changed")
		popup.rect_size = popupContainer.rect_size
		popup.visible = true
	
func onStarContainerMouseExited():
	popup.visible = false
