extends ObjectSkill

class_name Sword

@onready var hit_audio: AudioStreamPlayer2D = $HitAudio

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func turn_on_collision() -> void:
	collision_shape_2d.disabled = false

func turn_off_collision() -> void:
	collision_shape_2d.disabled = true

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		return
	
	if body is Zombo || Turtle:
		body.hit()
		hit_audio.play()
		GameManager.count_to_skill()
