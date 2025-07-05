extends Control

@onready var margin_container: MarginContainer = $MarginContainer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		margin_container.visible = false

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(GameManager.LEVEL_BASE)

func _on_credits_button_2_pressed() -> void:
	margin_container.visible = true
