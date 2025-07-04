extends Node

const WAVES: Array[WaveResource] = [
	preload("res://Resources/Wave1.tres"),
	preload("res://Resources/Wave2.tres"),
	preload("res://Resources/Wave3.tres"),
	preload("res://Resources/Wave4.tres"),
	preload("res://Resources/Wave5.tres"),
	preload("res://Resources/Wave6.tres")
]

const SKILLS: Array[PackedScene] = [
	preload("res://Scenes/skills/Chainsaw.tscn"),
	preload("res://Scenes/skills/Fireball.tscn"),
	preload("res://Scenes/skills/Arch.tscn"),
	preload("res://Scenes/skills/TennisBall.tscn"),
	preload("res://Scenes/skills/TimeBomb.tscn")
]

const CARDS_UI: Array[CompressedTexture2D] = [
	preload("res://Assets/cards/chainsaw_card.png"),
	preload("res://Assets/cards/fireball_card.png"),
	preload("res://Assets/cards/purple_hook_card.png"),
	preload("res://Assets/cards/tennis_ball_card.png"),
	preload("res://Assets/cards/time_bomb_card.png")
]

var score: int = 0
var player_health: int = 100
var kill_to_skill_count: int = 0

const KILL_TO_SKILL: int = 3

func count_to_skill() -> void:
	kill_to_skill_count += 1
	
	if kill_to_skill_count >= KILL_TO_SKILL:
		kill_to_skill_count = 0
		SignalHub.emit_on_skill_count_achieved()
	
	SignalHub.emit_on_enemy_killed()
