extends StaticBody2D

var C_frame = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2).timeout
	$AnimatedSprite2D.play("press_move")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	C_frame=$AnimatedSprite2D.get_frame()
	
	if C_frame == 5:
		$CollisionShape2D.disabled = false
		$CollisionShape2D2.disabled = true

	
	if C_frame == 4:
		$CollisionShape2D.disabled = true
		$CollisionShape2D2.disabled = false
	
