extends StaticBody2D

@export var value = 1
@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("animation")

func collect(inventory: Inventory):
	queue_free()
