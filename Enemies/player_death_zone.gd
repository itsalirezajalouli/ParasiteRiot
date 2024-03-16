extends Area2D

func _on_body_entered(body):
	if body.name == 'Player':
		global.type = "none"
		get_tree().change_scene_to_file("res://gameover.tscn")


func _on_body_exited(body):
	print('death')
