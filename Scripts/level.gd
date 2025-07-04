extends Node2D

class_name Level

@onready var portals: Array[Portal] = [$Portal, $Portal2, $Portal3]
var portal_waves: Dictionary = {} # Stores wave resources for each portal instance

func _ready() -> void:
	for portal in portals:
		# Initialize a new wave for each portal
		portal_waves[portal] = GameManager.WAVES.pick_random().duplicate() # Use duplicate to ensure each portal has its own unique wave instance

		# Connect signals using a common handler and pass the portal as an argument
		portal.on_portal_wave_timer_timeout.connect(_on_portal_wave_timer_timeout.bind(portal))
		portal.on_portal_spawn_timer_timeout.connect(_on_portal_spawn_timer_timeout.bind(portal))

		portal.play_spawn_timer()

func _spawn_enemies(portal_position: Vector2, scene: PackedScene) -> void:
	var instance = scene.instantiate()
	instance.position = portal_position
	get_tree().root.add_child(instance)

# This function now handles any portal's wave timer timeout
func _on_portal_wave_timer_timeout(portal: Portal) -> void:
	portal.play_spawn_timer()

# This function now handles any portal's spawn timer timeout
func _on_portal_spawn_timer_timeout(portal: Portal) -> void:
	var current_wave = portal_waves[portal]

	if current_wave.enemies.size() > 0:
		_spawn_enemies(portal.position, current_wave.enemies[0])
		current_wave.enemies.pop_front()
		portal.play_spawn_timer()
	else:
		# Get a new wave resource directly in the dictionary
		portal_waves[portal] = GameManager.WAVES.pick_random().duplicate() # Duplicate again for a fresh set of enemies
		portal.play_wave_timer()
