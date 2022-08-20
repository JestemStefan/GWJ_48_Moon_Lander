extends CanvasLayer

func _ready():
	GameManager.UI = self
	$BackToLevelSelect.visible = false
	$Restart.visible = false


func level_finished():
	$BackToLevelSelect.visible = true
	$Restart.visible = true


func _on_Restart_button_up():
	get_tree().reload_current_scene()


func _on_BackToLevelSelect_button_up():
	GameManager.UI = null
	get_tree().change_scene("res://scenes/menu/LevelSelection.tscn")
	MusicManager.play_main_menu_music()


func _on_BackToLevelSelect_mouse_entered():
	$HoverSFX.play()


func _on_Restart_mouse_entered():
	$HoverSFX.play()


func _on_BackToLevelSelect_button_down():
	$ClickSFX.play()


func _on_Restart_button_down():
	$ClickSFX.play()