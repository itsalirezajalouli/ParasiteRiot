extends StaticBody2D

@onready var interaction_area = $InteractionAreaSlow
@onready var sprite = $Sprite2D
@onready var animations = $AnimationPlayer

const slowpotion_instant = preload("res://inventory/items/potion3.tscn")

@export var animation_played = false

func _ready():
	interaction_area.interact = Callable(self, '_on_interact')
	
func _on_interact():
	if animation_played == false:
		var slowpotion = slowpotion_instant.instantiate()  
		get_parent().add_child(slowpotion)
		slowpotion.position = position
		slowpotion.position.x -= 20
		slowpotion.position.y += 15
		animations.play('open')
	animation_played = true
