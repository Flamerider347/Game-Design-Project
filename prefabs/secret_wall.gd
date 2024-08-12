extends Area2D

var position_changing = false
func _process(delta):
	if position_changing:
		$firework_node.position = Vector2(randi_range(-7936,-6656),randi_range(-256,-64))
func _on_area_entered(_area):
	position_changing = true
	$firework_node/firework.emitting = true
	$TileMap2.visible = false
	$godog.visible = true
	$gojo.visible = true
	$secret_text.visible = true


func _on_area_exited(area):
	position_changing = false	
	$firework_node/firework.emitting = false
