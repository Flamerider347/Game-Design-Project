extends Area2D

func _on_area_entered(area):
	if area is player_area:
		$breakable_wall_hitbox.position.y += 500
		$brick_wall_tilemap.position.y += 500
