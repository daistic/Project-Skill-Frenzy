extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword: Area2D = $Sword
@onready var action_timer: Timer = $ActionTimer

var walk_direction: float = 0.0
var skills: Array[PackedScene] = []
var can_act: bool = true
var sword_show_timer: float = 0.65

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -625.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("normal") and can_act:
		_normal_attack()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and not is_on_floor():
		velocity.y = 0.0
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	walk_direction = Input.get_axis("move_left", "move_right")
	if walk_direction:
		velocity.x = walk_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	_handle_animations()

func _handle_animations() -> void:
	if is_on_floor():
		if walk_direction == 0.0:
			animated_sprite_2d.play("Idle")
		else:
			animated_sprite_2d.play("Walk")
			_handle_sprite_facing()
	
	else:
		animated_sprite_2d.play("Jump")
		_handle_sprite_facing()

func _handle_sprite_facing() -> void:
	if walk_direction == 1.0:
		animated_sprite_2d.flip_h = false
		sword.scale.x = 1.0
	elif walk_direction == -1.0:
		animated_sprite_2d.flip_h = true
		sword.scale.x = -1.0

func _normal_attack() -> void:
	sword.show()
	can_act = false
	await get_tree().create_timer(sword_show_timer).timeout
	sword.hide()
	action_timer.start()

func _on_action_timer_timeout() -> void:
	can_act = true
