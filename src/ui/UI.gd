extends Control


func _ready():
	GameManager.UI = self
	$BackToLevelSelect.visible = false
	$Restart.visible = false


func level_finished():
	$BackToLevelSelect.visible = true
	$Restart.visible = true


func _on_Restart_button_up():
	get_tree().change_scene("res://scenes/levels/Tutorial.tscn")


func _on_BackToLevelSelect_button_up():
	GameManager.UI = null
	get_tree().change_scene("res://scenes/menu/LevelSelection.tscn")
