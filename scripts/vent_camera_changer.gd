extends Area2D

signal camera_limit

func _on_area_entered(_area):
	camera_limit.emit(-10000,-6144)
