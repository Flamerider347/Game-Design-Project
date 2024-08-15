extends Area2D


func _on_mouse_entered():
	$bu.scale = Vector2(1.5,1.5)
	$CollisionShape2D.scale = Vector2(1.5,1.5)
