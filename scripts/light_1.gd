extends Area2D



func _on_mouse_entered() -> void:
	$PointLight2D.enabled = true


func _on_mouse_exited() -> void:
	$PointLight2D.enabled = false
