extends StaticBody2D

@export var value = 0
@export var itemRes: InventoryItemm

func collect(inventory: Inventory):
	inventory.insert(itemRes)
	queue_free()
