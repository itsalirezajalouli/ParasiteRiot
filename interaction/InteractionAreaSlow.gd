extends Area2D
class_name InteractionAreaSlow

@export var action_name: String = 'interact'

var interact: Callable = func():
	pass





func _on_body_entered(body):
	Slowmanager.register_area(self)


func _on_body_exited(body):
	Slowmanager.unregister_area(self)

	
