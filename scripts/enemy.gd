extends Area2D
var speed = 2

signal respawn

func _process(_delta):
	$StaticBody2D2/Sprite2D.rotation_degrees += 8

func _on_area_entered(area):
	if area is player_main or godog:
		respawn.emit()
