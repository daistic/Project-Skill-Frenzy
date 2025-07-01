extends ProjectileSkill

@onready var rigidbody: RigidBody2D = $"."

@export var impulse: Vector2 = Vector2(125.0, -250.0)

func _ready() -> void:
	if !projectile_facing_right:
		var temp: float = impulse.x
		impulse = Vector2(-temp, impulse.y)
	
	rigidbody.apply_central_impulse(impulse)

func _on_timer_timeout() -> void:
	queue_free()
