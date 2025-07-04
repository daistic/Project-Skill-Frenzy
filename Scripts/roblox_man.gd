extends CharacterBody2D

class_name Roblox

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword: Sword = $Sword
@onready var action_timer: Timer = $ActionTimer

var walk_direction: float = 0.0
var skills: Array[PackedScene] = []
var can_act: bool = true
var sword_show_timer: float = 0.65

const MAX_SKILL_AMOUNT: int = 2
const SPEED: float = 300.0
const JUMP_VELOCITY: float = -625.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("normal") and can_act:
		_normal_attack()
	if event.is_action_pressed("skill_one") and can_act:
		_use_skill_one()
	if event.is_action_pressed("skill_two") and can_act:
		_use_skill_two()
	if event.is_action_pressed("debug"):
		_print_debug()

func _process(_delta: float) -> void:
	_handle_animations()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and not is_on_floor():
		velocity.y = 0.0
	
	walk_direction = Input.get_axis("move_left", "move_right")
	if walk_direction:
		velocity.x = walk_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

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
	sword.visible = true
	sword.turn_on_collision()
	can_act = false
	await get_tree().create_timer(sword_show_timer).timeout
	sword.hide()
	action_timer.start()

func store_skill(skill_scene: PackedScene) -> void:
	if skills.size() < MAX_SKILL_AMOUNT:
		skills.append(skill_scene)

func _use_skill_one() -> void:
	if skills.size() >= 1:
		var instance = skills[0].instantiate()
		if instance is ObjectSkill:
			instance.projectile_facing_right = !animated_sprite_2d.flip_h
			instance.position = position
			get_tree().root.add_child(instance)
		else:
			instance.position = position
			get_tree().root.add_child(instance)
		
		skills.remove_at(0)

func _use_skill_two() -> void:
	if skills.size() >= 2:
		var instance = skills[1].instantiate()
		if instance is ObjectSkill:
			instance.projectile_facing_right = !animated_sprite_2d.flip_h
			instance.position = position
			get_tree().root.add_child(instance)
		else:
			instance.position = position
			get_tree().root.add_child(instance)
		
		skills.remove_at(1)

func _print_debug() -> void:
	print(skills)

func _on_action_timer_timeout() -> void:
	can_act = true
