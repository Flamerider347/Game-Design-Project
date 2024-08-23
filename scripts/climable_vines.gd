extends Area2D

signal godog_can_climb
signal player_can_climb

func _on_area_entered(area):
	print(area)
	if area is godog_area:
		godog_can_climb.emit(true)
	if area is player_area:
		player_can_climb.emit(true)

func _on_area_exited(area):
	print(area)
	if area is godog_area:
		godog_can_climb.emit(false)
	if area is player_area:
		player_can_climb.emit(false)
