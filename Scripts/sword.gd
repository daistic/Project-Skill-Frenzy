extends ObjectSkill

class_name Sword

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func turn_on_collision() -> void:
	collision_shape_2d.disabled = false

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		return
	
	if body is Zombo || Turtle:
		body.hit()
