extends ObjectSkill

@onready var rigidbody: RigidBody2D = $"."
@onready var hit_audio: AudioStreamPlayer2D = $HitAudio

@export var impulse: Vector2 = Vector2(125.0, -250.0)

func _ready() -> void:
	if !projectile_facing_right:
		var temp: float = impulse.x
		impulse = Vector2(-temp, impulse.y)
	
	rigidbody.apply_central_impulse(impulse)

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	if body is StaticBody2D:
		return
	
	if body is Zombo || Turtle:
		body.hit()
		hit_audio.play()
		GameManager.count_to_skill()
