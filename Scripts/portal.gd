extends Sprite2D

class_name Portal

@export var wave_time: float = 13.0
@export var spawn_time: float = 6.5

@onready var wave_timer: Timer = $WaveTimer
@onready var spawn_timer: Timer = $SpawnTimer

signal on_portal_wave_timer_timeout
signal on_portal_spawn_timer_timeout

func _ready() -> void:
	wave_timer.wait_time = wave_time
	spawn_timer.wait_time = spawn_time

func play_wave_timer() -> void:
	wave_timer.start()

func play_spawn_timer() -> void:
	spawn_timer.start()

func _on_wave_timer_timeout() -> void:
	on_portal_wave_timer_timeout.emit()

func _on_spawn_timer_timeout() -> void:
	on_portal_spawn_timer_timeout.emit()
