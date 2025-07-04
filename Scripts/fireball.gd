extends ObjectSkill

@export var move_speed: float = 500.0

func _physics_process(delta: float) -> void:
	position.y -= move_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		return
	
	if body is Zombo || Turtle:
		body.hit()
