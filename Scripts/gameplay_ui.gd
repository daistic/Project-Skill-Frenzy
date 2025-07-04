extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var health_label: Label = $MarginContainer/HealthLabel

func _enter_tree() -> void:
	SignalHub.on_point_scored.connect(_add_score)

func _add_score(score: int) -> void:
	GameManager.score += score
	score_label.text = "%06d" % GameManager.score 
