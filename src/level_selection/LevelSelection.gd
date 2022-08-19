extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Level_1_button_up():
	print("Level 1 selected")
	get_tree().change_scene("res://scenes/levels/Tutorial.tscn")


func _on_Level_2_button_up():
	print("Level 2 selected")


func _on_Level_3_button_up():
	print("Level 3 selected")


func _on_Level_4_button_up():
	print("Level 4 selected")


func _on_Level_5_button_up():
	print("Level 5 selected")
