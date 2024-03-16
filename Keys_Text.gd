extends Label

func _on_LabelControl_label_update(new_text):
	text = new_text

func _ready():
	var hurtbox = get_node("/path/to/HurtBox/Node")  # Adjust path
	if hurtbox:
		print("HurtBox node not found!")
