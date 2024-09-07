extends Area2D


func _on_mouse_entered() -> void:
	$PointLight2D2.enabled = true


func _on_mouse_exited() -> void:
	$PointLight2D2.enabled = false


func _on_play_button_mouse_entered() -> void:
	$PointLight2D2.enabled = true
