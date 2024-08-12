extends Node2D

var main_camera_position
var player_camera_position
var godog_camera_position
var speed = 5

func _ready():
	pass
func _process(_delta):
	pass
func _on_player_swapped():
	pass
	
func _on_godog_swapped():
	pass


func _on_player_camera_update(_player_position):
	get_parent().get_node("player").get_node("player_camera").enabled = true
	get_parent().get_node("godog").get_node("godog_camera").enabled = false


func _on_godog_camera_update(_godog_position):
	get_parent().get_node("godog").get_node("godog_camera").enabled = true
	get_parent().get_node("player").get_node("player_camera").enabled = false
	
