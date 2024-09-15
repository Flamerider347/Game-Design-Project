extends Area2D
var locked = true
var can_enter_player = false
var can_enter_godog = false


signal level_3
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if can_enter_player and can_enter_godog and not locked:
		level_3.emit()
		locked = true


func _on_area_entered(area):
	if area is player_area:
		can_enter_player = true
	if area is godog_area:
		can_enter_godog = true

func _on_area_exited(area):
	if area is player_area:
		can_enter_player = false
	if area is godog_area:
		can_enter_godog = false


func _on_door_switch_flicked_on():
	locked = false
	$padlock_sprite.hide()


func _on_door_switch_flicked_off():
	locked = true
	$padlock_sprite.show()
