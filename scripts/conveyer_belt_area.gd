extends Area2D

signal player_moving
signal dog_moving
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area is godog_area:
		dog_moving.emit(true)
	if area is player_area:
		player_moving.emit(true)

func _on_area_exited(area: Area2D) -> void:
	if area is godog_area:
		dog_moving.emit(false)
	if area is player_area:
		player_moving.emit(false)
