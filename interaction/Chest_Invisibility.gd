extends StaticBody2D

@onready var interaction_area = $InteractionAreaInvisibility
@onready var sprite = $Sprite2D
@onready var animations = $AnimationPlayer

const invpotion_instant =  preload("res://inventory/items/potion2.tscn")

@export var animation_played = false

func _ready():
	interaction_area.interact = Callable(self, '_on_interact')
	
func _on_interact():
	if animation_played == false:
		var invpotion = invpotion_instant.instantiate()  
		get_parent().add_child(invpotion)
		invpotion.position = position
		invpotion.position.x -= 20
		invpotion.position.y += 15
		animations.play('open')
	animation_played = true
