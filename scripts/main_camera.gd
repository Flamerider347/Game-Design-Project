extends Node2D

var main_camera_position
var player_camera_position
var godog_camera_position
var speed = 5

signal godog_camera_limit
signal player_camera_limit
signal godog_camera_limit_y
signal player_camera_limit_y
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
	


func _on_vent_camera_changer_camera_limit(cam_limit_left,cam_limit_right,player_type):
	if player_type == "godog":
		godog_camera_limit.emit(cam_limit_left, cam_limit_right)
	elif player_type == "player":
		player_camera_limit.emit(cam_limit_left,cam_limit_right)


func _on_vent_camera_changer_3_camera_limit_y(cam_limit_top, cam_limit_bottom, player_type) -> void:
	if player_type == "godog":
		godog_camera_limit_y.emit(cam_limit_top, cam_limit_bottom)
	elif player_type == "player":
		player_camera_limit_y.emit(cam_limit_top,cam_limit_bottom)


func _on_game_camera_limit(cam_limit_left,cam_limit_right,player_type) -> void:
	if player_type == "godog":
		godog_camera_limit.emit(cam_limit_left, cam_limit_right)
	elif player_type == "player":
		player_camera_limit.emit(cam_limit_left,cam_limit_right)


func _on_game_camera_limit_y(cam_limit_top,cam_limit_bottom, player_type) -> void:
	if player_type == "godog":
		godog_camera_limit_y.emit(cam_limit_top, cam_limit_bottom)
	elif player_type == "player":
		player_camera_limit_y.emit(cam_limit_top,cam_limit_bottom)
