extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]


func insert(item: InvItem,qty:int = 1):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += qty
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = qty
	update.emit()

func count(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		return itemslots[0].amount
	else:
		return 0
		
		
func remove(item: InvItem,qty:int = 1):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount -= qty
	if !itemslots.is_empty() and itemslots[0].amount <= 0:
		itemslots[0].amount = 0
		itemslots[0].item = null
	update.emit()
