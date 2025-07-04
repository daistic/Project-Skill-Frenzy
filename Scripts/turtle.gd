extends RigidBody2D

class_name Turtle

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var score_label: Label = $ScoreLabel
@onready var timer: Timer = $ScoreLabel/Timer

@export var health: int = 1
@export var damage: int = 8
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
	if body is Roblox:
		body.hit(damage)

func hit() -> void:
	health -= 1
	if health <= 0:
		call_deferred("_die")
	print(health)

func _die() -> void:
	SignalHub.emit_on_point_scored(points)
	animated_sprite_2d.visible = false
	freeze = true
	collision_shape_2d.disabled = true
	score_label.visible = true
	timer.start()
	await timer.timeout
	queue_free()
