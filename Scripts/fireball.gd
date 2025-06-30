extends ProjectileSkill

@export var move_speed: float = 500.0

func _process(delta: float) -> void:
	position.y -= move_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
