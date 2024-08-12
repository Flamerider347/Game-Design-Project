extends Area2D
var rotation_speed = 1
var helicopter = true

signal respawn
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if helicopter:
		rotation_degrees += rotation_speed
	if not helicopter:
		rotation_degrees = 0

func _on_door_switch_flicked_on():
	helicopter = false


func _on_door_switch_flicked_off():
	helicopter = true


func _on_area_entered(area):
	if area is player_main or godog and helicopter:
		respawn.emit()
