extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area is player_area:
		print("It worked")
		get_tree().change_scene_to_file("res://prefabs/level_2.tscn")
