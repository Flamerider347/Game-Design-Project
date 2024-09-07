extends Area2D

func _on_area_entered(area):
	if area is player_area:
		$breakable_wall_hitbox.disabled = true
		$brick_wall_tilemap.collision_enabled = false
		$brick_wall_tilemap.hide()
