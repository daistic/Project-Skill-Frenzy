extends RigidBody2D

class_name Turtle

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var impulse_move_max: Vector2 = Vector2(300, 300)
@export var min_speed: Vector2 = Vector2(150, 150)
@export var health: int = 1
@export var points: int = 125

func _ready() -> void:
	_move_again()

func _physics_process(_delta: float) -> void:
	if linear_velocity.length() < min_speed.length():
		_move_again()
	
	_handle_sprite_facing()

func _move_again() -> void:
	var impulse_to_apply = Vector2(randf_range(-1, 1) * impulse_move_max.x, randf_range(-1, 1) * impulse_move_max.y)
	apply_central_impulse(impulse_to_apply)

func _handle_sprite_facing() -> void:
	if linear_velocity.x < 0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
