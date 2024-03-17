extends CanvasLayer
class_name Gameover

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var animation_player_2 = $AnimationPlayer2

func _ready():
	animation_player.play("idle")
	if animation_player_2 != null:
		animation_player_2.play("idle")

func _on_retry_pressed():
	get_tree().change_scene_to_file('res://game.tscn')
	#get_tree().sce()

func _on_quit_pressed():
	get_tree().quit()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://UI/canvas_layer.tscn")




