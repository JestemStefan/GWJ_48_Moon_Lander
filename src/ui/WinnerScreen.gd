extends Control

onready var stars := [
	$Panel/CenterContainer/VBoxContainer/HBoxContainer/Star1,
	$Panel/CenterContainer/VBoxContainer/HBoxContainer/Star2,
	$Panel/CenterContainer/VBoxContainer/HBoxContainer/Star3,
]

onready var fullTexture := preload("res://art/moon_full_star.png");

func _ready():
	GameManager.connect("wonLevel", self, "wonLevel")
	wonLevel(3)
	
func wonLevel(score: int) -> void:
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
