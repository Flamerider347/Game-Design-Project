extends CharacterBody2D
var target_position = Vector2(randi_range(100,1800),randi_range(100,900))
var SPEED_Y = randi_range(5,10)
var SPEED_X = randi_range(5,10)
var laser_left
var laser_right
var move_timer_started = false
var health = 500

@onready var dog_health = get_parent().get_node("dog_healthbar")
@onready var player_health = get_parent().get_node("player_healthbar")
func _ready() -> void:
	$drone_animation.play("drone_idle")
func _physics_process(_delta: float) -> void:
	if laser_left:
		if $laser_area.rotation_degrees < 180:
			$laser_area. rotation_degrees += 10
		else:
			laser_left = false
	if laser_right:
		if $laser_area. rotation_degrees > 0:
			$laser_area. rotation_degrees -= 10
		else:
			laser_right = false
	get_parent().get_node("drone_healthbar").value = health/5
	if position.x <= target_position.x -10:
		position.x += SPEED_X
		$drone_animation.flip_h = false
		laser_right = true
		$drone_animation.play("drone_forward")
	if position.x >= target_position.x +10:
		position.x -= SPEED_X
		$drone_animation.flip_h = true
		laser_left = true
		$drone_animation.play("drone_forward")
	if position.y <= target_position.y +10:
		position.y += SPEED_Y
	if position.y >= target_position.y -10:
		position.y -= SPEED_Y
	if position.x >= target_position.x -10 and position.x <= target_position.x + 10 and position.y <= target_position.y + 10 and position.y >= target_position.y - 10:
		$drone_animation.play("drone_idle")
		if not move_timer_started:
			move_timer_started = true
			$move_timer.start(2)
	move_and_slide()
func _on_move_timer_timeout() -> void:
	SPEED_Y = randi_range(5,10)
	SPEED_X = randi_range(5,10)
	move_timer_started = false
	target_position = Vector2(randi_range(100,1800),randi_range(500,900))


func _on_drone_area_area_entered(area: Area2D) -> void:
	if area is godog_area:
		var damage = get_parent().get_parent().get_node("godog").throw_power
		get_parent().get_parent().get_node("godog").throw_power = 0
		health -= round(damage)


func _on_laser_area_area_entered(area: Area2D) -> void:
	if area is godog_area:
		dog_health.value -= 5
	if area is player_area:
		player_health.value -= 5
