extends Control

var shop_buy_is_open = false
var item: InvItem

@onready var shop_inv: ShopInv = preload("res://Resources/shop_inv.tres")
@onready var shop_slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var gc: Node2D = $".."
@onready var buy_sprite: Sprite2D = $NinePatchRect/buy_panel/NinePatchRect/buy_item_sprite
@onready var buy_price_label: Label = $NinePatchRect/buy_panel/NinePatchRect/buy_item_price_label
@onready var shop_sell: Control = $"../shop_sell"


func _ready():
	shop_inv.update.connect(update_slots)
	update_slots()
	close()
	buy_sprite.visible = false
	buy_price_label.visible = false


func _process(delta):
	pass


func _input(event):
	if Input.is_action_just_pressed("b"):
		if shop_buy_is_open:
			close()
		else:
			shop_sell.close()
			open()

func _shortcut_one(event):
	if Input.is_action_just_pressed("e") and shop_buy_is_open == true:
		_on_buy_one_button_pressed()
		
func _shortcut_ten(event):
	if Input.is_action_just_pressed("t") and shop_buy_is_open == true:
		_on_buy_ten_button_pressed()


func update_slots():
	for i in range(min(shop_inv.shop_slots.size(), shop_slots.size())):
		shop_slots[i].update(shop_inv.shop_slots[i])
	for node in $NinePatchRect/GridContainer.get_children():
		if node._slot != null and node._slot.item != null:
			node.visible = true
		else:
			node.visible = false


func open():
	visible = true
	shop_buy_is_open = true


func close():
	visible = false
	shop_buy_is_open = false


func shop_close_button_pressed() -> void:
	close()


func _on_buy_one_button_pressed() -> void:
	if item and (gc.monies - item.buy_price) >= 0:
		gc.buy_item(1)
		gc.update_monies()
		


func _on_buy_ten_button_pressed() -> void:
	if item and (gc.monies - (item.buy_price * 10)) >= 0:
		gc.buy_item(10)
		gc.update_monies()
