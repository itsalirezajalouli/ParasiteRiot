extends Control

signal opened
signal closed

var isOpen: bool = false

func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()


func _on_quit_pressed():
	get_tree().quit()


func _on_return_pressed():
	close()




func _on_menu_pressed():
	get_tree().change_scene_to_file("res://UI/canvas_layer.tscn")
