extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var move_speed: float = 50.0

func _process(delta: float) -> void:
	position.x += move_speed * delta

func _on_body_entered(body: Node2D) -> void:
	animated_sprite_2d.play("destroyed")
	await animated_sprite_2d.animation_finished
	queue_free()
