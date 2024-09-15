extends Area2D
var speed = 2
var kill = false
signal respawn

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	kill = true
func _process(_delta):
	$StaticBody2D2/Sprite2D.rotation_degrees += 8

func _on_area_entered(area):
	if area is player_area or godog_area and kill:
		respawn.emit()
