extends Line2D
var target_position = Vector2(100,100)

@onready var godog_var = get_parent().get_node("godog")
@onready var player_var = get_parent().get_node("player")
func _ready():
	pass
func _process(delta):
	if Input.is_action_pressed("player_throw") and player_var.picked_up:
		position = godog_var.position
		var speed = godog_var.throw_power
		update_trajectory(Vector2(speed*1.4,-speed*1.8),2,160, delta)
	if Input.is_action_just_released("player_throw"):
		clear_points()


func update_trajectory(dir: Vector2, speed: float, gravity: float, delta : float) -> void:
	clear_points()
	var max_points = 6 * godog_var.throw_power
	var pos: Vector2 = Vector2.ZERO
	var vel =  dir * speed
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta
		pos += vel * delta
