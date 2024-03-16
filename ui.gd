extends CanvasLayer
class_name UI
@onready var label = $Control/AvatarFrame/Label
@onready var inventory = $InventoryGui
@onready var score_label = %Label
@onready var parasites_freed = %"Parasites Freed"
@onready var pauseMenu = $Pause

var score = 0
var maxScore = 30
var parasite = 0

func _ready():
	inventory.close()
	pauseMenu.close()

func update_score(value):
	score += value
	parasite += value
	update_score_label()
	
func update_score_label():
	score_label.text = str(score)
	parasites_freed.value = parasite

func _input(event):
	if event.is_action_pressed('toggle_inventory'):
		if inventory.isOpen:
			inventory.close()
			if global.speed_potion_used:
				$SpeedPotionTimer.start(5)
			if global.invisibility_potion_used:
				$InvisibilityPotionTimer.start(5)
			if global.slow_potion_used:
				$SlowPotionTimer.start(5)
		else:
			inventory.open()
	if event.is_action_pressed('ui_cancel'):
		if pauseMenu.isOpen:
			pauseMenu.close()
		else:
			pauseMenu.open()
			

func _on_speed_potion_timer_timeout():
	global.speedAnimation = false
	global.playerSpeed = 120

func _on_invisibility_potion_timer_timeout():
	global.detectzone = false
	global.deathzone = false
	global.invisible = false


func _on_slow_potion_timer_timeout():
	global.scientistSpeed = 50
	global.scientistDetectionSpeed = 85
