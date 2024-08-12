extends Node2D

var respawn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if respawn:
		_respawn()


func _on_door_1_level_2():
	if $player.picked_up == true:
		$player.position = Vector2(4500,900)
	else:
		$player.position = Vector2(4500,900)
		$godog.position = Vector2(4600,900)


func _on_enemy_respawn():
	respawn = true
	


func _on_tutorial_spike_trap_respawn():
	respawn = true

func _respawn():
	respawn = false
	$godog.position = $godog.godog_respawn_position
	$player.position = $player.player_respawn_position
