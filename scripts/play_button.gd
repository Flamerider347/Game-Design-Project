extends Button



func _on_mouse_entered() -> void:
	$AudioStreamPlayer2D.play()
