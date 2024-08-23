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
		update_trajectory(Vector2(speed*0.7 *player_var.direction,-speed*0.9),2,40, delta)
	if Input.is_action_just_released("player_throw"):
		clear_points()


func update_trajectory(dir: Vector2, speed: float, gravity: float, delta : float) -> void:
	var max_points = 8 * round(godog_var.throw_power)
	var pos: Vector2 = Vector2.ZERO
	var vel =  dir * speed
	clear_points()
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta
		pos += vel * delta
