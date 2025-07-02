extends CharacterBody2D

var path: PackedScene

func _ready() -> void:
	path = GameManager.WALK_PATHS[randi_range(0, GameManager.WALK_PATHS.size())]
	print(path)
