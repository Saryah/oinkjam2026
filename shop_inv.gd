extends Resource

class_name ShopInv

signal update

@export var shop_slots: Array[InvSlot]


func shop_insert(item: InvItem,qty:int = 1):
	var itemslots = shop_slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += qty
	else:
		var emptyslots = shop_slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = qty
	update.emit()

func count(item: InvItem):
	var itemslots = shop_slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		return itemslots[0].amount
	else:
		return 0
		
		
