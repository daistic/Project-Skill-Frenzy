extends Control

@onready var label: Label = $VBoxContainer/Label

func _ready() -> void:
	label.text = "You Scored:\n %d" % GameManager.score

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn") #
