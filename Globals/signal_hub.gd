extends Node

signal on_point_scored
signal on_player_hit

func emit_on_point_scored(score: int) -> void:
	on_point_scored.emit(score)

func emit_on_player_hit() -> void:
	on_player_hit.emit() 
