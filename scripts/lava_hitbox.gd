extends Area2D

signal respawn
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area is player_area or godog_area:
		respawn.emit()
