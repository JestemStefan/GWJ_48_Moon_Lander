extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idel")


func _on_StartButton_button_down():
	$ClickSFX.play()

func _on_StartButton_button_up():
	get_tree().change_scene("res://scenes/menu/LevelSelection.tscn")
	
func _on_ExitButton_button_down():
	$ClickSFX.play()

func _on_ExitButton_button_up():
	$ClickSFX.play()
	get_tree().quit()
	
func _on_StartButton_mouse_entered():
	$HoverSFX.play()


func _on_ExitButton_mouse_entered():
	$HoverSFX.play()


func _on_CreditsButton_button_up():
	get_tree().change_scene("res://scenes/menu/Credits.tscn")


func _on_CreditsButton_button_down():
	$ClickSFX.play()


func _on_CreditsButton_mouse_entered():
	$HoverSFX.play()
