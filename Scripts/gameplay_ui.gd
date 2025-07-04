extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var health_label: Label = $MarginContainer/HealthLabel
@onready var skill_in_label: Label = $MarginContainer/HBoxContainer/SkillInLabel

@onready var skill_one_rect: TextureRect = $MarginContainer/HBoxContainer/SkillOneRect
@onready var skill_two_rect: TextureRect = $MarginContainer/HBoxContainer/SkillTwoRect

func _enter_tree() -> void:
	SignalHub.on_point_scored.connect(_add_score)
	SignalHub.on_player_hit.connect(_update_player_health)
	SignalHub.on_skill_get.connect(_update_skill_ui)
	SignalHub.on_enemy_killed.connect(_update_skill_in_label)

func _ready() -> void:
	SignalHub.emit_on_gameui_ready()

func _add_score(score: int) -> void:
	GameManager.score += score
	score_label.text = "%06d" % GameManager.score 

func _update_player_health() -> void:
	health_label.text = "%d" % GameManager.player_health
	health_label.text += "%"

func _update_skill_ui(skills: Array[PackedScene]) -> void:
	skill_one_rect.texture = null
	skill_two_rect.texture = null
	
	if skills.is_empty() || skills.size() > 2:
		return
	
	var skill_one_index: int = -1
	var skill_two_index: int = -1
	
	if skills.size() >= 1:
		var skill_instance_one = skills[0].instantiate()
		if skill_instance_one != null and skill_instance_one is ObjectSkill:
				skill_one_index = skill_instance_one.skill_index
				skill_instance_one.queue_free()
	
	if skills.size() == 2:
		var skill_instance_two = skills[1].instantiate()
		if skill_instance_two != null and skill_instance_two is ObjectSkill:
				skill_two_index = skill_instance_two.skill_index
				skill_instance_two.queue_free()
	
	if skill_one_index != -1:
		if skill_one_index < GameManager.CARDS_UI.size():
			skill_one_rect.texture = GameManager.CARDS_UI[skill_one_index]
	else:
		skill_one_rect.texture = null
	
	if skill_two_index != -1:
		if skill_two_index < GameManager.CARDS_UI.size():
			skill_two_rect.texture = GameManager.CARDS_UI[skill_two_index]
	else:
		skill_two_rect.texture = null

func _update_skill_in_label() -> void:
	print(GameManager.kill_to_skill_count)
	skill_in_label.text = "Skill In: %d" % (GameManager.KILL_TO_SKILL - GameManager.kill_to_skill_count)
