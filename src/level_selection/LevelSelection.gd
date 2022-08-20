extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Level_1_button_up():
	get_tree().change_scene("res://scenes/levels/Tutorial.tscn")
	MusicManager.play_level_music()


func _on_Level_2_button_up():
	get_tree().change_scene("res://scenes/levels/Level_2.tscn")
	MusicManager.play_level_music()


func _on_Level_3_button_up():
	get_tree().change_scene("res://scenes/levels/Level_3.tscn")
	MusicManager.play_level_music()


func _on_Level_4_button_up():
	get_tree().change_scene("res://scenes/levels/Level_4.tscn")
	MusicManager.play_level_music()


func _on_Level_5_button_up():
	get_tree().change_scene("res://scenes/levels/Level_5.tscn")
	MusicManager.play_level_music()


func _on_Level_1_mouse_entered():
	$HoverSFX.play()


func _on_Level_2_mouse_entered():
	$HoverSFX.play()


func _on_Level_3_mouse_entered():
	$HoverSFX.play()


func _on_Level_4_mouse_entered():
	$HoverSFX.play()


func _on_Level_5_mouse_entered():
	$HoverSFX.play()


func _on_Level_1_button_down():
	$ClickSFX.play()


func _on_Level_2_button_down():
	$ClickSFX.play()


func _on_Level_3_button_down():
	$ClickSFX.play()


func _on_Level_4_button_down():
	$ClickSFX.play()


func _on_Level_5_button_down():
	$ClickSFX.play()
