extends Area2D
class_name player_area
signal in_range
signal not_in_range
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area):
	if area is godog_area:
		in_range.emit()


func _on_area_exited(area):
	if area is godog_area:
		not_in_range.emit()
