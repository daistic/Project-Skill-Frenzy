extends Node

@onready var waves: Array[WaveResource] = [
	preload("res://Resources/Wave1.tres"),
	preload("res://Resources/Wave2.tres"),
	preload("res://Resources/Wave3.tres"),
	preload("res://Resources/Wave4.tres"),
	preload("res://Resources/Wave5.tres"),
	preload("res://Resources/Wave6.tres")
]

var score: int = 0
