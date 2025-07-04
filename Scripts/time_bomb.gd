extends ObjectSkill

@onready var explosion_sprites: Array[Sprite2D] = [$Sprite2D2, $Sprite2D3, $Sprite2D4, $Sprite2D5]
@onready var explosion_collisions: Array[CollisionShape2D] = [$CollisionShape2D, $CollisionShape2D2, $CollisionShape2D3, $CollisionShape2D4]

const EXPLOSION_TIME = 0.1
const EXPLOSION_SPRITE_TIME = 0.5

func _on_timer_timeout() -> void:
	for sprite in explosion_sprites:
		sprite.show()
	for collision in explosion_collisions:
		collision.disabled = false
	
	await get_tree().create_timer(EXPLOSION_TIME).timeout
	for collision in explosion_collisions:
		collision.disabled = true
	
	await get_tree().create_timer(EXPLOSION_SPRITE_TIME).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		return
	
	if body is Zombo || Turtle:
		body.hit()
		GameManager.count_to_skill()
