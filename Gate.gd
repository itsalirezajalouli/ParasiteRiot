extends StaticBody2D

@onready var can_intract = false
@onready var gate_state = false # false means close
@onready var label = $Label

@export var gate_id = "none"
# Called when the node enters the scene tree for the first time.
func _ready():
	
	if gate_id=="none":
			label.text = '[J]'
	else:
		label.text = '[J] Only ' + str(gate_id)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_intract and Input.is_action_just_pressed("interact"):
		if gate_state:
			gate_state=false
			$AnimationPlayer.play("close")
			$CollisionShape2D.disabled=false
		else:
			gate_state=true
			$AnimationPlayer.play("open")
			$CollisionShape2D.disabled=true

func _on_intract_body_entered(body):
	label.visible = true
	if body.name=="Player" and (global.type == gate_id or gate_id=="none") :
		can_intract=true


func _on_intract_body_exited(body):
	label.visible = false
	if body.name=="Player":
		can_intract=false
