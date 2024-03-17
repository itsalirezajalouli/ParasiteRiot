extends Node
var type = "none"
var key_found = []
var playerSpeed = 120
var speedAnimation = false
var detectzone = false
var deathzone = false
var invisible = false
var speed_potion_used = false
var invisibility_potion_used = false
var slow_potion_used = false
var scientistSpeed = 50
var scientistDetectionSpeed = 85
var can_interact = true
var can_interact_inv = true
var can_interact_slow = true
var eyes = 0
var Card_used = false



var unlocked = 0
var save_location ="user://data.json"
var path ="user://data.json"
var detail = {"unlocked": 0}

func save(content):
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_string(JSON.new().stringify(content))


func loading():
	var json_as_text = FileAccess.get_file_as_string(path)
	if not json_as_text:
		return 0
	var json_as_dict = JSON.parse_string(json_as_text)
	detail = json_as_dict
	unlocked = detail["unlocked"]
