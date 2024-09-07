extends Area2D
class_name player_area
var can_interact = false
signal in_range

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area):
	if area is godog_area:
		can_interact = true
		in_range.emit(can_interact)


func _on_area_exited(area):
	if area is godog_area:
		can_interact = false
		in_range.emit(can_interact)
