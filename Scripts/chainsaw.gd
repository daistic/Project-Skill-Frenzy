extends ObjectSkill

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_audio: AudioStreamPlayer2D = $HitAudio

@export var move_speed: float = 50.0

func _ready() -> void:
	if not projectile_facing_right:
		move_speed = - move_speed

func _physics_process(delta: float) -> void:
	position.x += move_speed * delta

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body is StaticBody2D:
		move_speed = 0
		animated_sprite_2d.play("destroyed")
		await animated_sprite_2d.animation_finished
		queue_free()
		return
	
	if body is Zombo || Turtle:
		body.hit()
		hit_audio.play()
		GameManager.count_to_skill()
