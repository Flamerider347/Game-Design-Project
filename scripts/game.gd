extends Node2D
var level = 1
var respawn = false
signal camera_limit
signal camera_limit_y
func _ready() -> void:
	$ColorRect.show()
	$AnimationPlayer.play("fade_to_black")
	respawn = false
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("player_debug"):
		level = 3
		$AnimationPlayer.play("unfade_to_black")
		await get_tree().create_timer(1.0).timeout
		$player.player_respawn_position = Vector2(-9280,4240)
		$godog.godog_respawn_position = Vector2(-9280,4240)
		camera_limit.emit(0,1920,"godog")
		camera_limit.emit(0,1920,"player")
		camera_limit_y.emit(0,1080,"godog")
		camera_limit_y.emit(0,1080,"player")
		if $player.picked_up:
			$player.position = Vector2(210,750)
		else:
			$player.position = Vector2(210,750)
			$godog.position = Vector2(210,750)
			await get_tree().create_timer(1.0).timeout
			$AnimationPlayer.play("fade_to_black")

	if respawn == true:
		_respawn()


func _on_door_1_level_2():
	level = 2
	$AnimationPlayer.play("unfade_to_black")
	await get_tree().create_timer(1).timeout
	$player.player_respawn_position = Vector2(-9280,4240)
	$godog.godog_respawn_position = Vector2(-9280,4240)
	camera_limit.emit(-9400,1920,"godog")
	camera_limit.emit(-9400,1920,"player")
	camera_limit_y.emit(0,4608,"godog")
	camera_limit_y.emit(0,4608,"player")
	if $player.picked_up:
		$player.position = Vector2(-9280,4240)
	else:
		$player.position = Vector2(-9280,4240)
		$godog.position = Vector2(-9280,4240)
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("fade_to_black")

func _on_enemy_respawn():
	respawn = true

func _on_lava_hitbox_respawn() -> void:
	respawn = true

func _respawn():
	if level == 1:
		camera_limit.emit(-6272,-3456,"godog")
		camera_limit.emit(-6272,-3456,"player")
	if level == 2:
		camera_limit.emit(-9400,1920,"godog")
		camera_limit.emit(-9400,1920,"player")
		camera_limit_y.emit(0,4608,"godog")
		camera_limit_y.emit(0,4608,"player")
	if level == 3:
		camera_limit.emit(-6272,0,"godog")
		camera_limit.emit(-6272,0,"player")
	respawn = false
	$godog.position = $godog.godog_respawn_position
	$player.position = $player.player_respawn_position


func _on_door_1_level_3() -> void:
	level = 3
	$AnimationPlayer.play("unfade_to_black")
	await get_tree().create_timer(1.0).timeout
	$player.player_respawn_position = Vector2(210,750)
	$godog.godog_respawn_position = Vector2(210,750)
	camera_limit.emit(0,1920,"godog")
	camera_limit.emit(0,1920,"player")
	camera_limit_y.emit(0,1080,"godog")
	camera_limit_y.emit(0,1080,"player")
	if $player.picked_up:
		$player.position = Vector2(210,750)
	else:
		$player.position = Vector2(210,750)
		$godog.position = Vector2(210,750)
	await get_tree().create_timer(1.0).timeout
	$AnimationPlayer.play("fade_to_black")
