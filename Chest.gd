extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $Sprite2D
@onready var animations = $AnimationPlayer

const speedpotion_instant =   preload("res://World/grass.tscn")

@export var animation_played = false

func _ready():
	animations.play('off')
	interaction_area.interact = Callable(self, '_on_interact')
	
func _on_interact():
	if animation_played == false:
		var speedpotion = speedpotion_instant.instantiate()  
		get_parent().add_child(speedpotion)
		speedpotion.position = position
		speedpotion.position.x -= 20
		speedpotion.position.y += 15
		animations.play('open')
	animation_played = true
