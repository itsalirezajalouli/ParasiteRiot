extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $Sprite2D
@onready var animations = $AnimationPlayer

@export var animation_played = false

func _ready():
	interaction_area.interact = Callable(self, '_on_interact')
	
func _on_interact():
	if interaction_area.action_name == 'close':
		if animation_played == false:
			animations.play('close')
			get_node("CollisionShape2D").disabled = false
			interaction_area.action_name = 'open'
	else:
		animations.play('open')
		get_node("CollisionShape2D").disabled = true
		interaction_area.action_name = 'close'
	animation_played = true
		
