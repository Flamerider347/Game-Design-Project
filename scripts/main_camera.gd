extends Node2D

var target
var distance
var speed = 1
var switch_camera = false
var camera 
var cameras
var other_camera
var other_target
# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_parent().get_node("player")
	cameras = get_tree().get_nodes_in_group("cameras")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if switch_camera:
		if other_camera.position.x != target.position.x:
			distance = other_camera.position.x - target.position.x 
			if other_camera.position.x < target.position.x:
				other_camera.position.x -= distance * speed * delta
			else:
				other_camera.position.x += distance * speed * delta
		if position == target.position:
			other_camera.enabled = false
			camera.enabled = true
			switch_camera = false
#		if other_camera.position.x > target.position.x:
#			distance = other_camera.position.x - target.position.x
#			other_camera.position.x += distance * speed * delta



func _on_player_swapped():
	target = get_parent().get_node("godog")
	switch_camera = true
	camera = target.get_node("godog_camera")
	other_target = get_parent().get_node("player")
	other_camera = other_target.get_node("player_camera")

	
func _on_godog_swapped():
	target = get_parent().get_node("player")
	switch_camera = true
	camera = target.get_node("player_camera")
	other_target = get_parent().get_node("godog")
	other_camera = other_target.get_node("godog_camera")
