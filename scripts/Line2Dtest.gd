extends Line2D
var target_position = Vector2(100,100)
func _ready():
	pass
func _process(delta):
	if Input.is_action_pressed("player_throw") and get_parent().get_node("player").picked_up:
		position = get_parent().get_node("godog").position
		clear_points()
		var speed = get_parent().get_node("godog").throw_power
		update_trajectory(Vector2(speed*0.7,-speed*0.9),2,40,delta)
	if Input.is_action_just_released("player_throw"):
		clear_points()


func update_trajectory(dir: Vector2, speed: float, gravity: float, delta: float) -> void:
	var max_points = 10 * get_parent().get_node("godog").throw_power
	clear_points()
	var pos: Vector2 = Vector2.ZERO
	var vel =  dir * speed
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta
		pos += vel * delta
