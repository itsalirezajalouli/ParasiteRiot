extends Button

@onready var backgroudSprite: Sprite2D = $bg
@onready var container: CenterContainer = $CenterContainer

@onready var inventory = preload("res://inventory/playerInventory.tres")

var itemStackGui: ItemStackGui
var index: int

func insert(isg: ItemStackGui):
	itemStackGui = isg
	backgroudSprite.frame = 1
	container.add_child(itemStackGui)
	
	if !itemStackGui.inventorySlot || inventory.slots[index] == itemStackGui.inventorySlot:
		return
		
	inventory.insertSlot(index, itemStackGui.inventorySlot)

func takeItem():
	var item = itemStackGui
	
	inventory.removeSlot(itemStackGui.inventorySlot)
	
	container.remove_child(itemStackGui)
	itemStackGui = null
	backgroudSprite.frame = 0
	
	return item
	
func isEmpty():
	return !itemStackGui
