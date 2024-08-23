extends Area2D
var locked = true
var can_enter = false

signal level_2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if can_enter and not locked and Input.is_action_just_pressed("both_interact"):
		level_2.emit()


func _on_area_entered(area):
	if area is player_area and godog_area:
		can_enter = true


func _on_area_exited(area):
	if area is player_area or godog_area:
		can_enter = false


func _on_door_switch_flicked_on():
	locked = false
	$padlock_sprite.hide()


func _on_door_switch_flicked_off():
	locked = true
	$padlock_sprite.show()
