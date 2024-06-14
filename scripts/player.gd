extends CharacterBody2D

@export var EXPLOSION_FORCE:float = 500.00
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
