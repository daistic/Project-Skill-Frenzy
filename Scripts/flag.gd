extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var cooldown_label: Label = $CooldownLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var _test_skill_scene: PackedScene

func _process(delta: float) -> void:
	cooldown_label.text = str(int(cooldown_timer.time_left))

func _start_cooldown() -> void:
	collision_shape_2d.disabled = true
	cooldown_label.visible = true
	cooldown_timer.start()
	animation_player.play("dim")

func _on_body_entered(body: Node2D) -> void:
	if body is Roblox:
		print("ok")
		body.get_random_skill()
		call_deferred("_start_cooldown")

func _on_cooldown_timer_timeout() -> void:
	collision_shape_2d.disabled = false
	cooldown_label.visible = false
	animation_player.play("RESET")
