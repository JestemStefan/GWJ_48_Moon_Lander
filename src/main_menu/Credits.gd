extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("start")


func _on_Button_button_up():
	get_tree().change_scene("res://scenes/menu/MainMenu.tscn")


func _on_Button_button_down():
	$ClickSFX.play()


func _on_Button_mouse_entered():
	$HoverSFX.play()
