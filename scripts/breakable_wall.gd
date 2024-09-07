extends Area2D

func _on_area_entered(area):
	if area is godog_area:
		$breakable_wall_hitbox.disabled = true
		$window_tilemap.hide()
