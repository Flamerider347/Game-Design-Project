extends Line2D
var velocity = Vector2.ZERO
var side_force = 10
var up_force = 10
var throw_power = 20
var charge_multiplier = 1.8
var charge_times = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var max_points = 300
	clear_points()
	for i in max_points:
		if Input.is_action_pressed("player_throw"):
			if throw_power > 100:
				charge_multiplier = -0.3
			if charge_times < 10:
				charge_times += 1
			if throw_power < 20:
				charge_multiplier = 1.8
			throw_power += charge_multiplier
			velocity = Vector2(side_force * throw_power * 0.5, -up_force * throw_power *1.2)
			position += velocity
			add_point(self.position)
		if Input.is_action_just_released("player_throw"):
			position = Vector2.ZERO
