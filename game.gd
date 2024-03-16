extends Node2D
class_name Game

@export var player: Player
@export var ui: UI

func _ready():
	if !player.collected.is_connected(ui._on_collected):
		player.collected.connect(ui._on_collected)
