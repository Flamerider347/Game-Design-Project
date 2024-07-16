extends CharacterBody2D
class_name godog
const SPEED = 3.0
const JUMP_VELOCITY = -500.0
var disabled_timer = 0
var is_disabled = true
var position_update = false
var is_thrown = false
var apply_gravity = true
var side_force = 1000
var up_force = 1000
var controlling = false
var can_swap = false

signal velocity_timer
signal dog_swap_timer
signal update_position
signal swapped
signal thrown

@onready var player = get_parent().get_node("player")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if position_update == true:
		update_position.emit()
		is_disabled = true
	if Input.is_action_just_pressed("player_throw") and player.picked_up:
		position_update = false
		is_disabled = false
		apply_gravity = true
		controlling = true
		can_swap = true
		velocity = Vector2(side_force, -up_force)
		player.picked_up = false
		thrown.emit()
		velocity_timer.emit()
	if is_thrown == true and is_on_floor():
		is_thrown = false
		velocity = Vector2.ZERO

	if is_disabled == false:
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
	is_disabled = true
	position_update = true
	apply_gravity = false
	position = Vector2(player_position.x+100, player_position.y+90)


func _on_player_dropped():
	position_update = false
	apply_gravity = true


func _on_timer_timeout():
	is_thrown = true


func dog_swapped():
	is_disabled = true
	controlling = false
	can_swap = false
	swapped.emit()


func _on_player_swapped():
	is_disabled = false
	controlling = true
	dog_swap_timer.emit()


func _on_dog_swap_timer_timeout():
	can_swap = true

