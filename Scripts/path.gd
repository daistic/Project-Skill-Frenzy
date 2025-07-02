extends Node2D

class_name Path

var waypoints: Array[Marker2D] = []

func _ready() -> void:
	for waypoint in get_children():
		waypoints.append(waypoint)
