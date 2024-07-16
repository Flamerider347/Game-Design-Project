extends Area2D
var can_interact = false
var flicked = false
var interact_timeout = true

signal switch_timer
signal flicked_on
signal flicked_off
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if can_interact and Input.is_action_just_pressed("both_interact") and not flicked and interact_timeout:
		flicked = true
		$switch_on.show()
		$switch_off.hide()
		interact_timeout = false
		switch_timer.emit()
		flicked_on.emit()
	if can_interact and Input.is_action_just_pressed("both_interact") and flicked and interact_timeout:
		flicked = false
		$switch_on.hide()
		$switch_off.show()
		interact_timeout = false
		switch_timer.emit()
		flicked_off.emit()
func _on_area_entered(_area):
	can_interact = true


func _on_area_exited(_area):
	can_interact = false


func _on_switch_timer_timeout():
	interact_timeout = true
