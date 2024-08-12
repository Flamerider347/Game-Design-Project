extends CharacterBody2D
#region Variables + Signals
class_name player_main
const SPEED = 6
const JUMP_VELOCITY = -400.0
var gravity = 980
var interact_cooldown = 0
var player_respawn_position = Vector2(-6080, 850)
var can_throw = false
var picked_up = false
var controlling = true
var player_can_swap = true
var can_climb = false

signal pick_up
signal dropped
signal swapped
signal camera_update

#endregion

func _physics_process(delta):
	if Input.is_action_just_pressed("player_debug"):
		print("player", controlling)
	camera()
	moving(delta)
	picking_up(delta)
	swapping()

#region Movement & Camera
func moving(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if controlling:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if Input.is_action_pressed("player_left"):
			position.x -= SPEED
		if Input.is_action_pressed("player_right"):
			position.x += SPEED
		if can_climb:
			if Input.is_action_pressed("ui_accept"):
				position.y -= SPEED
				velocity = Vector2.ZERO
			else: 
				velocity.y = 40
	move_and_slide()
func camera():
	if controlling:
		camera_update.emit(self.position)
func _on_climable_vines_player_can_climb(climable):
	can_climb = climable

#endregion
#region Picking up
func _on_player_area_in_range(in_range):
	can_throw = in_range

func picking_up(delta):
	if Input.is_action_just_pressed("player_pickup") and not picked_up and can_throw and interact_cooldown >= 0.5:
		pick_up.emit(self.position)
		picked_up = true
		interact_cooldown = 0
		controlling = true
		player_can_swap = true
	if Input.is_action_just_pressed("player_pickup") and picked_up and interact_cooldown >= 0.5:
		dropped.emit()
		picked_up = false
		interact_cooldown = 0
	interact_cooldown += delta
func _on_godog_update_position():
	pick_up.emit(self.position)

#endregion
#region Swapping
func swapping():
	if Input.is_action_just_pressed("player_swap") and controlling and player_can_swap and not picked_up:
		player_swap()

func player_swap():
	controlling = false
	player_can_swap = false
	swapped.emit()

func _on_godog_swapped():
	controlling = true
	$swap_timer.start(1)

func _on_swap_timer_timeout():
	player_can_swap = true

func _on_godog_thrown():
	controlling = false
	player_can_swap = false
	picked_up = false
#endregion
#region Throwing
func _on_godog_throw_charge(power):
	if power == 0:
		$throw_power_label.text = str(" ")
	else:
		$throw_power_label.text = str(round(power))
#endregion
