extends Node

signal on_gameui_ready
signal on_point_scored
signal on_player_hit
signal on_skill_get
signal on_enemy_killed
signal on_skill_count_achieved

func emit_on_gameui_ready() -> void:
	on_gameui_ready.emit()

func emit_on_point_scored(score: int) -> void:
	on_point_scored.emit(score)

func emit_on_player_hit() -> void:
	on_player_hit.emit() 

func emit_on_skill_get(skills: Array[PackedScene]) -> void:
	on_skill_get.emit(skills)

func emit_on_enemy_killed() -> void:
	on_enemy_killed.emit()

func emit_on_skill_count_achieved() -> void:
	on_skill_count_achieved.emit()
