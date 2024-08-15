extends Area2D

signal camera_limit

func _on_area_entered(area):
	if area is godog_area:
		camera_limit.emit(-8064,-6144,"godog")
	if area is player_area:
		camera_limit.emit(-8064,-6144,"player")
