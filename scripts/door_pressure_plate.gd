extends Area2D

var stepped_on = false
@onready var door = get_parent().get_node("tutorial_door")

func _process(delta: float) -> void:
	if stepped_on:
		if door.position.y > -192:
			door.position.y -= 2
	if not stepped_on:
		if door.position.y < 0:
			door.position.y += 2
func _on_area_entered(area: Area2D) -> void:
	if area is godog_area:
		stepped_on = true


func _on_area_exited(area: Area2D) -> void:
	if area is godog_area:
		stepped_on = false
