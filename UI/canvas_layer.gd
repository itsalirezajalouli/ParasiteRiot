extends CanvasLayer

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("idle")



func _on_quit_pressed():
	get_tree().quit()


func _on_levels_pressed():
	pass # Replace with function body.


func _on_start_pressed():
	get_tree().change_scene_to_file('res://game.tscn')


func _on_levels_2_pressed():
	pass

func _on_creators_pressed():
	get_tree().change_scene_to_file("res://UI/creators.tscn")
