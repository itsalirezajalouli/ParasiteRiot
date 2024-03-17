extends CanvasLayer

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _ready():
	pass


func _on_levels_2_pressed():
	get_tree().change_scene_to_file("res://Player/tutorial2.tscn")
