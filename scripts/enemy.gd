extends Area2D
var speed = 2
var helicopter = true
var direction = 1
var move = "down"
signal respawn
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if helicopter:
		position.y += speed*direction
		if position.y < 92:
			direction = 1
		if position.y > 930:
			direction = -1
	if not helicopter:
		rotation_degrees = 0

func _on_door_switch_flicked_on():
	helicopter = false


func _on_door_switch_flicked_off():
	helicopter = true


func _on_area_entered(area):
	if area is player_main or godog and helicopter:
		respawn.emit()
