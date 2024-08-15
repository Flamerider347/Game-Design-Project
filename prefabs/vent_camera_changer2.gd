extends Area2D

signal camera_limit

func _on_area_entered(area):
	if area is godog_area:
		camera_limit.emit(-6272,0,"godog")
	if area is player_area:
		camera_limit.emit(-6272,0,"player")
