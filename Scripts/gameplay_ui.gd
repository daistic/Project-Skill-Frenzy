extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var health_label: Label = $MarginContainer/HealthLabel

func _enter_tree() -> void:
	SignalHub.on_point_scored.connect(_add_score)
	SignalHub.on_player_hit.connect(_update_player_health)

func _add_score(score: int) -> void:
	GameManager.score += score
	score_label.text = "%06d" % GameManager.score 

func _update_player_health() -> void:
	health_label.text = "%d" % GameManager.player_health
	health_label.text += "%"
