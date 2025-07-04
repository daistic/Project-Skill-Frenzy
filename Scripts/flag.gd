extends Area2D

@export var _test_skill_scene: PackedScene

func _on_body_entered(body: Node2D) -> void:
	if body is Roblox:
		print("ok")
		body.get_random_skill()
