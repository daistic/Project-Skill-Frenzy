extends Node2D

class_name Level

@onready var portal: Sprite2D = $Portal
@onready var portal_2: Sprite2D = $Portal2
@onready var portal_3: Sprite2D = $Portal3

var portal_wave: WaveResource = GameManager.waves[randi_range(0, GameManager.waves.size())]
var portal2_wave: WaveResource = GameManager.waves[randi_range(0, GameManager.waves.size())]
var portal3_wave: WaveResource = GameManager.waves[randi_range(0, GameManager.waves.size())]

func _spawn_enemies(portal_position: Vector2, scene: PackedScene) -> void:
	var instance = scene.instantiate()
	instance.position = portal_position
	get_tree().root.add_child(instance)

func _on_portal_wave_timer_timeout() -> void:
	pass # Replace with function body.

func _on_portal_spawn_timer_timeout() -> void:
	pass # Replace with function body.

func _on_portal2_wave_timer_timeout() -> void:
	pass # Replace with function body.

func _on_portal2_spawn_timer_timeout() -> void:
	pass # Replace with function body.

func _on_portal3_wave_timer_timeout() -> void:
	pass # Replace with function body.

func _on_portal3_spawn_timer_timeout() -> void:
	pass # Replace with function body.
