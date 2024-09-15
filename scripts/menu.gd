extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.show()
	$AnimationPlayer.play("fade_to_black")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("controller_start"):
			$AnimationPlayer.play("unfade_to_black")
			await get_tree().create_timer(0.8).timeout
			$play_button.hide()
			$option_button.hide()
			$controls_button.hide()
			await get_tree().create_timer(0.2).timeout
			get_tree().change_scene_to_file("res://prefabs/game.tscn")

func _on_play_button_pressed() -> void:
	$AnimationPlayer.play("unfade_to_black")
	await get_tree().create_timer(0.8).timeout
	$play_button.hide()
	$option_button.hide()
	$controls_button.hide()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://prefabs/game.tscn")
