extends StaticBody2D

@export var value = 0
@export var itemRes: InventoryItemm
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("idle")

func collect(inventory: Inventory):
	inventory.insert(itemRes)
	audio_stream_player_2d.play()
	queue_free()
