extends Area2D


func _on_mouse_entered() -> void:
	$PointLight2D3.enabled = true


func _on_mouse_exited() -> void:
	$PointLight2D3.enabled = false
