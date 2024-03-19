extends CanvasLayer

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var animation_player_2 = $AnimationPlayer2

func _ready():
	animation_player_2.play("possess")


func _on_levels_2_pressed():
	get_tree().change_scene_to_file("res://UI/canvas_layer.tscn")
