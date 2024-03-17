extends StaticBody2D

@export var value = 0
@export var itemRes: InventoryItemm
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func collect(inventory: Inventory):
	global.eyes += 1
	inventory.insert(itemRes)
	audio_stream_player_2d.play()
	queue_free()
