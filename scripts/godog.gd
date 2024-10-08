extends CharacterBody2D
#region Variables + Signals
class_name godog
const SPEED = 4.5
const JUMP_VELOCITY = -620.0
var charge_multiplier = 1.8
var godog_respawn_position = Vector2(-5950, 920)
var throw_power = 20
var side_force = 10
var up_force = 10
var gravity = 980
var health = 100
var is_disabled = true
var position_update = false
var is_thrown = false
var apply_gravity = true
var controlling = false
var can_swap = false
var emit_position = false
var charging = false
var can_climb = false
var climbing = false
var flashlight_enabled = false
var flashlight_timer_timeout = true
var godog_conveyor = false

signal update_position
signal swapped
signal thrown
signal camera_update
signal throw_charge

@onready var player_var = get_parent().get_node("player")
@onready var godog_anim = $godog_animation
# Get the gravity from the project settings to be synced with RigidBody nodes.


#endregion 
func _physics_process(delta: float) -> void:
	flashlight()
	throwing(delta)
	swapping()
	camera()
	moving(delta)
	emit_position_update()

#region Movement, Respawning, Throwing, Camera & Flashlight
func moving(_delta):
	if godog_conveyor and not player_var.picked_up:
		position.x += 5
	if not Input.is_action_pressed("player_left") and not Input.is_action_pressed("player_right") and not is_thrown:
		godog_anim.play("idle_dog")
	if controlling:
		if Input.is_action_just_released("player_flashlight"):
			if not flashlight_enabled and flashlight_timer_timeout:
				flashlight_timer_timeout = false
				$flashlight/flashlight_timer.start(0.1)
				$flashlight.show()
				flashlight_enabled = true
			if flashlight_enabled and flashlight_timer_timeout:
				flashlight_timer_timeout = false
				$flashlight/flashlight_timer.start(0.1)
				$flashlight.hide()
				flashlight_enabled = false
		if Input.is_action_pressed("player_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if Input.is_action_pressed("player_left"):
			position.x -= SPEED
			godog_anim.flip_h = true
			godog_anim.play("default")
		if Input.is_action_pressed("player_right"):
			position.x += SPEED
			godog_anim.flip_h = false
			godog_anim.play("default")
		if can_climb:
			if Input.is_action_pressed("player_jump"):
				climbing = true
				position.y -= SPEED
				velocity = Vector2.ZERO
			else: 
				velocity.y = 40
	if not is_on_floor() and apply_gravity and not climbing:
		velocity.y += gravity * _delta
	move_and_slide()
	
func _on_conveyer_belt_area_dog_moving(dog_moving) -> void:
	godog_conveyor = dog_moving

func _on_climable_vines_godog_can_climb(climbable):
	can_climb = climbable
	if not can_climb:
		climbing = false

func throwing(_delta):
	if charging:
		throw_charge.emit(throw_power)
	if is_on_floor():
		throw_power = 0
	if Input.is_action_pressed("player_throw") and player_var.picked_up:
		if not charging:
			throw_power = 20
		controlling = false
		charging = true
		if throw_power > 100:
			charge_multiplier = -0.3
		if throw_power < 20:
			charge_multiplier = 1.8
		throw_power += charge_multiplier

	if Input.is_action_just_released("player_throw") and charging:
		godog_anim.play("dog_jump")
		is_thrown = true
		charging = false
		position_update = false
		apply_gravity = true
		can_swap = true
		velocity = Vector2(side_force * throw_power * 0.7 * player_var.direction, -up_force * throw_power*0.9)
		throw_charge.emit(0)
		thrown.emit()

	if is_thrown and is_on_floor():
		controlling = true
		is_thrown = false
		velocity = Vector2.ZERO

func camera():
	if controlling or is_thrown:
		camera_update.emit(self.position)

func _on_camera_manager_godog_camera_limit(limit_left, limit_right):
	$godog_camera.limit_left = limit_left
	$godog_camera.limit_right = limit_right

func _on_camera_manager_godog_camera_limit_y(cam_limit_top, cam_limit_bottom) -> void:
	$godog_camera.limit_top = cam_limit_top
	$godog_camera.limit_bottom = cam_limit_bottom

func _on_flashlight_timer_timeout() -> void:
	flashlight_timer_timeout = true

func flashlight():
	if $godog_animation.flip_h == true:
		$flashlight.rotation_degrees = 180
	if $godog_animation.flip_h == false:
		$flashlight.rotation_degrees = 0

#endregion
#region Picking up
func emit_position_update():
	if position_update:
		update_position.emit()
		is_disabled = true

func _on_player_pick_up(player_position, direction):
	controlling = false
	position_update = true
	apply_gravity = false
	can_swap = false
	if direction == 1:
		position = Vector2(player_position.x-20, player_position.y+45)
		$godog_animation.flip_h = false
	if direction == -1:
		position = Vector2(player_position.x+20, player_position.y+45)
		$godog_animation.flip_h = true
func _on_player_dropped():
	position_update = false
	apply_gravity = true
	charging = false
	throw_power = 0

#endregion
#region Swapping
func swapping():
	if Input.is_action_just_pressed("player_swap") and controlling and can_swap:
		dog_swapped()

func dog_swapped():
	godog_anim.play("idle_dog")
	controlling = false
	can_swap = false
	swapped.emit()

func _on_player_swapped():
	controlling = true
	$dog_swap_timer.start(1)

func _on_dog_swap_timer_timeout():
	can_swap = true

#endregion
