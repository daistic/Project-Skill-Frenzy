extends RigidBody2D

@export var _move_speed: float = 125.0
@export var _acceleration_force: float = 100.0
@export var _jump_power: float = 650.0
var _move_direction: int = -1

func _physics_process(_delta: float) -> void:
	var target_velocity_x = _move_speed * _move_direction
	var current_velocity_x = linear_velocity.x
	
	var force_x = (target_velocity_x - current_velocity_x) * _acceleration_force
	apply_central_force(Vector2(force_x, 0))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Wall"):
		_move_direction = -_move_direction
	if body.is_in_group("EnemyJump"):
		jump()

func jump() -> void:
	apply_central_impulse(Vector2(0, -_jump_power))
	print ("tried jumping")
