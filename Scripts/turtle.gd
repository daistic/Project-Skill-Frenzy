extends RigidBody2D

class_name Turtle

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var health: int = 1
@export var points: int = 225
@export var _move_speed: float = 225.0
@export var _acceleration_force: float = 100.0
@export var _flap_power: float = 500.0
var _move_direction: int = -1

func _physics_process(_delta: float) -> void:
	var target_velocity_x = _move_speed * _move_direction
	var current_velocity_x = linear_velocity.x
	
	var force_x = (target_velocity_x - current_velocity_x) * _acceleration_force
	apply_central_force(Vector2(force_x, 0))
	
	_handle_sprite_facing()

func _handle_sprite_facing() -> void:
	if _move_direction == -1:
		animated_sprite_2d.flip_h = false
	if _move_direction == 1:
		animated_sprite_2d.flip_h = true

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Wall"):
		_move_direction = -_move_direction
		apply_central_impulse(Vector2(0, -_flap_power))
