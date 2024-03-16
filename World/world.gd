extends Node2D

@onready var ui = %Ui

func update_ui_score(value):
	ui.update_score(value)


func _on_inventory_gui_closed():
	get_tree().paused = false


func _on_inventory_gui_opened():
	get_tree().paused = true


func _on_pause_closed():
	get_tree().paused = false


func _on_pause_opened():
	get_tree().paused = true

func _exit_tree():
	queue_free()
