extends Button


func _on_pressed():
	get_tree().change_scene_to_file("res://prefabs/game.tscn")

func _on_button_down():
	scale = Vector2(1.25,1.25)
