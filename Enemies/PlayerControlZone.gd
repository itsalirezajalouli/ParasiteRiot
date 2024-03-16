extends Area2D
@onready var scientist = $".."

#func _on_body_entered(body):
func _physics_process(delta):
	if has_overlapping_bodies( ):
		var flag=false
		var hosts = get_overlapping_bodies()
		for i in hosts:
			if i.name == "Player":
				flag=true
				var host=i
		if Input.is_action_just_pressed("ui_text_submit") and flag:
			global.type = scientist.id
			# transition animation 
			scientist.queue_free()


func _on_body_exited(body):
	print('no control')

		
