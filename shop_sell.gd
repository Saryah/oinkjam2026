extends Control

var shop_sell_is_open = false
var item: InvItem

@onready var inv: Inv = preload("res://Resources/player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var gc: Node2D = $".."
@onready var sell_sprite: Sprite2D = $NinePatchRect/sell_panel/NinePatchRect/sell_item_sprite
@onready var sell_label: Label = $NinePatchRect/sell_panel/NinePatchRect/sell_item_label
@onready var sell_price_label: Label = $NinePatchRect/sell_panel/NinePatchRect/sell_item_price_label
@onready var shop_buy: Control = $"../shop_buy"


func _ready():
	gc.inv = inv
	inv.update.connect(update_slots)
	update_slots()
	close()
	sell_sprite.visible = false
	sell_label.visible = false
	sell_price_label.visible = false


func _process(delta):
	pass


func _input(event):
	if Input.is_action_just_pressed("s"):
		if shop_sell_is_open:
			close()
		else:
			shop_buy.close()
			open()


func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	for node in $NinePatchRect/GridContainer.get_children():
		if node._slot != null and node._slot.item != null and node._slot.item.sellable:
			node.visible = true
		else:
			node.visible = false


func open():
	visible = true
	shop_sell_is_open = true


func close():
	visible = false
	shop_sell_is_open = false


func inv_close_button_pressed() -> void:
	close()


func clear():
	if inv.count(item) <= 0:
		sell_sprite.visible = false
		sell_label.visible = false
		sell_price_label.visible = false
		item = null


func _on_sell_one_button_pressed() -> void:
	if item:
		if item.name == "carrot":
			gc.carrot_sold += 1
		elif item.name == "lettuce":
			gc.lettuce_sold += 1
		elif item.name == "tomato":
			gc.tomato_sold += 1
		elif item.name == "watermelon":
			gc.watermelon_sold += 1
		gc.seed_unlock_check()
		gc.monies += item.sell_price
		inv.remove(item, 1)
		clear()
		gc.update_monies()
		

func _on_sell_ten_button_pressed() -> void:
	if item:
		if item.name == "carrot":
			gc.carrot_sold += clamp(inv.count(item), 0, 10)
		elif item.name == "lettuce":
			gc.lettuce_sold += clamp(inv.count(item), 0, 10)
		elif item.name == "tomato":
			gc.tomato_sold += clamp(inv.count(item), 0, 10)
		elif item.name == "watermelon":
			gc.watermelon_sold += clamp(inv.count(item), 0, 10)
		gc.seed_unlock_check()
		gc.monies += (item.sell_price * clamp(inv.count(item), 0, 10))
		inv.remove(item, clamp(inv.count(item), 0, 10))
		clear()
		gc.update_monies()

func _on_sell_all_button_pressed() -> void:
	if item:
		if item.name == "carrot":
			gc.carrot_sold += inv.count(item)
		elif item.name == "lettuce":
			gc.lettuce_sold += inv.count(item)
		elif item.name == "tomato":
			gc.tomato_sold += inv.count(item)
		elif item.name == "watermelon":
			gc.watermelon_sold += inv.count(item)
		gc.seed_unlock_check()
		gc.monies += (item.sell_price * inv.count(item))
		inv.remove(item, inv.count(item))
		clear()
		gc.update_monies()


func _on_sell_ui_button_pressed() -> void:
		if shop_sell_is_open:
			close()
		else:
			shop_buy.close()
			open()
