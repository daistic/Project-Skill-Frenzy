extends Node

signal on_point_scored

func emit_on_point_scored(score: int) -> void:
	on_point_scored.emit(score)
