extends CharacterBody2D
const SPEED = 5
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_throw = false
var picked_up = false
var is_disabled = false
var controlling = true
var player_can_swap = true
var interact_cooldown = 0

signal pick_up
signal dropped
signal swapped
signal swap_timer
signal camera_update

func _physics_process(delta):
	moving(delta)
	picking_up()
	move_and_slide()
	if Input.is_action_just_pressed("player_swap") and controlling and player_can_swap and not picked_up:
		player_swap()
	interact_cooldown += delta

#region functions
func _on_player_area_in_range():
	can_throw = true


func _on_player_area_not_in_range():
	can_throw = false


func _on_godog_update_position():
	pick_up.emit(self.position)


func picking_up():
	if Input.is_action_just_pressed("player_pickup") and not picked_up and controlling and can_throw and interact_cooldown >= 0.5:
		pick_up.emit(self.position)
		picked_up = true
		interact_cooldown = 0
	if Input.is_action_just_pressed("player_pickup") and picked_up and interact_cooldown >= 0.5:
		dropped.emit()
		picked_up = false
		interact_cooldown = 0


func player_swap():
	is_disabled = true 	
	controlling = false
	player_can_swap = false
	swapped.emit()


func moving(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if not is_disabled:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if Input.is_action_pressed("player_left"):
			position.x -= SPEED
		if Input.is_action_pressed("player_right"):
			position.x += SPEED


func _on_godog_swapped():
	is_disabled = false
	controlling = true
	swap_timer.emit()


func _on_swap_timer_timeout():
	player_can_swap = true


func _on_godog_thrown():
	is_disabled = true
	controlling = false
	player_can_swap = false


#endregion
