extends StaticBody2D

@onready var interaction_area = $InteractionArea
@onready var sprite = $Sprite2D
@onready var animations = $AnimationPlayer2

const speedpotion_instant = preload("res://Player/friend.tscn")

@export var animation_played = false
@onready var timer = $Timer

func _ready():
	animations.play('idle')
	interaction_area.interact = Callable(self, '_on_interact')
	
func _on_interact():
	if animation_played == false:
		var speedpotion = speedpotion_instant.instantiate()  
		get_parent().add_child(speedpotion)
		speedpotion.position = position
		speedpotion.position.x -= 30
		speedpotion.position.y += 30
		animations.play('empty')
		timer.start(3)
	animation_played = true
	



func _on_timer_timeout():
	get_tree().change_scene_to_file("res://UI/canvas_layer.tscn")
