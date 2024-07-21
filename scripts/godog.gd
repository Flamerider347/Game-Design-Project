extends CharacterBody2D
class_name godog
const SPEED = 3.0
const JUMP_VELOCITY = -500.0
var disabled_timer = 0
var is_disabled = true
var position_update = false
var is_thrown = false
var apply_gravity = true
var side_force = 10
var up_force = 10
var controlling = false
var can_swap = false
var emit_position = false
var throw_power = 0
var charging = false

signal velocity_timer
signal dog_swap_timer
signal update_position
signal swapped
signal thrown
signal camera_update
signal throw_charge

@onready var player = get_parent().get_node("player")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if controlling:
		camera_update.emit(self.position)
	if position_update == true:
		update_position.emit()
		is_disabled = true
	if charging:
		throw_charge.emit(throw_power)
	if not charging:
		throw_charge.emit(0)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and player.picked_up:
		charging = true
		if throw_power < 100:
			throw_power += 1
	if Input.is_action_just_released("player_throw") and charging:
		charging = false
		position_update = false
		apply_gravity = true
		controlling = true
		can_swap = true
		velocity = Vector2(side_force * throw_power * 0.8, -up_force * throw_power)
		throw_power = 0
		player.picked_up = false
		thrown.emit()
		velocity_timer.emit()


	if is_thrown == true and is_on_floor():
		is_thrown = false
		velocity = Vector2.ZERO

	if controlling:
		moving(delta)
	if not is_on_floor() and apply_gravity:
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("player_swap") and controlling and can_swap:
		dog_swapped()


	move_and_slide()

func moving(_delta):
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("player_left"):
		position.x -= SPEED
	if Input.is_action_pressed("player_right"):
		position.x += SPEED

func _on_player_pick_up(player_position):
	controlling = false
	position_update = true
	apply_gravity = false
	position = Vector2(player_position.x+100, player_position.y+90)


func _on_player_dropped():
	position_update = false
	apply_gravity = true


func _on_timer_timeout():
	is_thrown = true


func dog_swapped():
	controlling = false
	can_swap = false
	swapped.emit()


func _on_player_swapped():
	controlling = true
	dog_swap_timer.emit()


func _on_dog_swap_timer_timeout():
	can_swap = true

