extends Area2D
class_name InteractionAreaInvisibility

@export var action_name: String = 'interact'

var interact: Callable = func():
	pass





func _on_body_entered(body):
	Invismanager.register_area(self)


func _on_body_exited(body):
	Invismanager.unregister_area(self)

	
