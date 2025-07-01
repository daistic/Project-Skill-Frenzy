extends ProjectileSkill

@export var initial_speed: float = 300.0 
@export var initial_vertical_velocity: float = -200.0 

var velocity: Vector2 = Vector2.ZERO

const GRAVITY = 980.0

func _ready() -> void:
	if projectile_facing_right:
		velocity = Vector2.RIGHT * initial_speed
	else:
		velocity = Vector2.LEFT * initial_speed
	
	velocity.y = initial_vertical_velocity # Add the initial upward velocity

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
