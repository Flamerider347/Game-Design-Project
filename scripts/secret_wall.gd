extends Area2D
var position_changing = false
var timer_going = false

func _on_area_entered(_area):
	$secret_wall_tilemap.visible = false
	$godog.visible = true
	$gojo.visible = true
	$secret_text.visible = true
