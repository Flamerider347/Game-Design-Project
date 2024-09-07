extends CharacterBody2D
var target_position = Vector2(randi_range(100,1800),randi_range(100,900))
var SPEED_Y = randi_range(5,10)
var SPEED_X = randi_range(5,10)
var move_timer_started = false
var health = 1000

func _ready() -> void:
	$drone_animation.play("drone_idle")
func _physics_process(_delta: float) -> void:
	$Label.text = str(health)
	if position.x < target_position.x -10.5:
		position.x += SPEED_X
		$drone_animation.flip_h = false
		$PointLight2D. rotation_degrees = 0
		$drone_animation.play("drone_forward")
	if position.x > target_position.x +10.5:
		position.x -= SPEED_X
		$drone_animation.flip_h = true
		$PointLight2D. rotation_degrees = 180
		$drone_animation.play("drone_forward")
	if position.y < target_position.y +10.5:
		position.y += SPEED_Y
	if position.y > target_position.y -10.5:
		position.y -= SPEED_Y
	if position.x > target_position.x -10.5 and position.x < target_position.x + 10.5 and position.y < target_position.y + 10.5 and position.y > target_position.y - 10.5:
		$drone_animation.play("drone_idle")
		if not move_timer_started:
			move_timer_started = true
			$move_timer.start(2)
	move_and_slide()
func _on_move_timer_timeout() -> void:
	SPEED_Y = randi_range(5,10)
	SPEED_X = randi_range(5,10)
	move_timer_started = false
	target_position = Vector2(randi_range(100,1800),randi_range(100,900))


func _on_drone_area_area_entered(area: Area2D) -> void:
	if area is godog_area:
		var damage = get_parent().get_parent().get_node("godog").throw_power
		get_parent().get_parent().get_node("godog").throw_power = 0
		health -= round(damage)
