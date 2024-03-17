extends VBoxContainer

var unlocked = 0
var save_location ="user://data.json"
var path ="user://data.json"
var detail = global.detail
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	global.loading()
	unlocked = global.unlocked
	detail = global.detail
	for level in get_children():
		if str_to_var(level.name) in range(global.unlocked + 2):
			print(1)
			level.disabled = false
		level.connect("button_up", Callable(self, "change_level").bind(level.name))

func change_level(lvl):
	get_tree().change_scene_to_file("res://levels/level" + lvl + ".tscn")

#func loading():
	#var file = File.new()
	#if file.file_exists(save_location):
		#file.open(save_location,file.READ)
		#var test_json_conv = JSON.new()
		#test_json_conv.parse(file.get_as_text())
		#detail = test_json_conv.get_data()
		#Data.unlocked = detail["unlocked"]
