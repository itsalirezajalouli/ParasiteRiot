extends Control

signal opened
signal closed

var isOpen: bool = false
@onready var inventory = preload("res://inventory/playerInventory.tres")
@onready var ItemStackGuiClass = preload("res://inventory/itemStackGui.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var slot_gui = $"."
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


var itemInHand: ItemStackGui

func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()
	
	
func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)
		
func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item: continue
		
		var itemStackGui: ItemStackGui = slots[i].itemStackGui
		
		if !itemStackGui:
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
			
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()
		
func open():
	
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()
	
	
func onSlotClicked(slot):
	if slot.isEmpty():
		if !itemInHand: return
		insertItemInSlot(slot)
		return
		
	if !itemInHand:
		takeItemFromSlot(slot)
		return
	
	if slot.itemStackGui.inventorySlot.item.name == itemInHand.inventorySlot.item.name:
		stackItems(slot)
		return
	swapItems(slot)


func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()
	
func insertItemInSlot(slot):
	var item = itemInHand
	remove_child(itemInHand)
	itemInHand = null
	slot.insert(item)
	
func swapItems(slot):
	var tempItem = slot.takeItem()
	
	insertItemInSlot(slot)
	
	itemInHand = tempItem
	add_child(itemInHand)
	updateItemInHand()
	
func stackItems(slot):
	var slotItem: ItemStackGui = slot.itemStackGui
	var maxAmount = slotItem.inventorySlot.item.stackSize
	var totalAmount = slotItem.inventorySlot.amount + itemInHand.inventorySlot.amount
	
	if slotItem.inventorySlot.amount == maxAmount:
		swapItems(slot)
		return
	if totalAmount <= maxAmount:
		slotItem.inventorySlot.amount = totalAmount
		remove_child(itemInHand)
		itemInHand = null
	else:
		slotItem.inventorySlot.amount = maxAmount
		itemInHand.inventorySlot.amount = totalAmount - maxAmount
	slotItem.update()
	if itemInHand: itemInHand.update()
	
func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2

func removeItem():
	if is_instance_valid(itemInHand):
		if itemInHand.inventorySlot.item.name == 'speedPotion':
			global.playerSpeed += 140
			global.speedAnimation = true
			global.speed_potion_used = true
			itemInHand.queue_free()
	
	if itemInHand.inventorySlot.item.name == 'invisibilityPotion':
		if is_instance_valid(itemInHand):
			global.invisible = true
			global.detectzone = true
			global.deathzone = true
			global.invisibility_potion_used = true
			itemInHand.queue_free()

func _input(event):
	if itemInHand && Input.is_action_just_pressed('rightClick'):
		audio_stream_player_2d.play()
		removeItem()
		
	updateItemInHand()
	
	
func removeAll():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		
		if !inventorySlot.item: continue
		
		var itemStackGui: ItemStackGui = slots[i].itemStackGui

		slots[i].takeItem()
			
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()
		

func _exit_tree():
	removeAll()
	



