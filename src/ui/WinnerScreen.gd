extends Control

onready var stars := [
	$Panel/CenterContainer/VBoxContainer/HBoxContainer/Star1,
	$Panel/CenterContainer/VBoxContainer/HBoxContainer/Star2,
	$Panel/CenterContainer/VBoxContainer/HBoxContainer/Star3,
]

onready var fullTexture := preload("res://art/moon_full_star.png")
onready var successLabel: Label = $Panel/CenterContainer/VBoxContainer/SuccessLabel
onready var failureLabel: Label = $Panel/CenterContainer/VBoxContainer/FailureLabel

export var maximumTimeForStar: float = 30
export var minimumFuelForStar: int = 500

func _ready():
	GameManager.connect("wonLevel", self, "wonLevel")
	GameManager.connect("failedLevel", self, "failedLevel")
	GameManager.maximumTime = maximumTimeForStar
	GameManager.minimumFuel = minimumFuelForStar

func wonLevel(score: int) -> void:
	successLabel.visible = true
	visible = true
	showScore(score)

func showScore(score: int) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	
	for n in score:
		tween.tween_property(stars[n - 1], "texture", fullTexture, 0.1)
		tween.tween_property(stars[n - 1], "rect_scale", Vector2(2, 2), 0.1)
		tween.tween_property(stars[n - 1], "rect_rotation", 360.0, 0.75)
		tween.parallel().tween_property(stars[n - 1], "rect_scale", Vector2(1, 1), 0.75)
		tween.tween_interval(0.5)

func failedLevel(msg: String) -> void:
	failureLabel.visible = true
	failureLabel.text = msg
	visible = true

func onRestartButtonPressed():
	$ClickSFX.play()
	get_tree().reload_current_scene()

func onBackToLevelSelectButtonPressed():
	$ClickSFX.play()
	get_tree().change_scene("res://scenes/menu/LevelSelection.tscn")
	MusicManager.play_main_menu_music()

func onRestartMouseEntered():
	$HoverSFX.play()

func onBackToLevelSelectMouseEntered():
	$HoverSFX.play()
