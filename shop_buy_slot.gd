extends Panel

var _slot: InvSlot

@onready var shop_buy: Control = $"../../.."
@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var buy_panel_sprite: Sprite2D = $"../../buy_panel/NinePatchRect/buy_item_sprite"
@onready var panel_price_label: Label = $"../../buy_panel/NinePatchRect/buy_item_price_label"
@onready var item_price_label: Label = $CenterContainer/Panel/buy_item_price_label


func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		visible = false
		item_price_label.visible = false
		_slot = null
	else:
		visible = true
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		_slot = slot
		item_price_label.text = "$" + str(_slot.item.buy_price)
		


func _on_button_pressed():
	shop_buy.item = _slot.item
	buy_panel_sprite.texture = item_visual.texture
	panel_price_label.text = str(item_price_label.text)
	buy_panel_sprite.visible = true
	panel_price_label.visible = true
