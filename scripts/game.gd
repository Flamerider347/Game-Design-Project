extends Node2D

var respawn = false
signal camera_limit

func _process(_delta):
	if $player.position.y > 1500:
		_respawn()
	if respawn:
		_respawn()


func _on_door_1_level_2():
	if $player.picked_up == true:
		$player.position = Vector2(4500,900)
	else:
		$player.position = Vector2(4500,900)
		$godog.position = Vector2(4600,900)


func _on_enemy_respawn():
	respawn = true
	


func _on_tutorial_spike_trap_respawn():
	respawn = true

func _respawn():
	respawn = false
	camera_limit.emit(-6272,0,"godog")
	camera_limit.emit(-6272,0,"player")
	$godog.position = $godog.godog_respawn_position
	$player.position = $player.player_respawn_position
