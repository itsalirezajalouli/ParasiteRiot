extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $Sprite2D
@onready var animations = $AnimationPlayer

@export var animation_played = false

func _ready():
	interaction_area.interact = Callable(self, '_on_interact')
	
func _on_interact():
	if animation_played == false:
		animations.play('open')
	animation_played = true
