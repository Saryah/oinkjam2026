extends Panel

var _slot: InvSlot

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label
@onready var sell_sprite: Sprite2D = $"../../../../shop_sell/NinePatchRect/sell_panel/NinePatchRect/sell_item_sprite"
@onready var sell_label: Label = $"../../../../shop_sell/NinePatchRect/sell_panel/NinePatchRect/sell_item_label"
@onready var sell_price_label: Label = $"../../../../shop_sell/NinePatchRect/sell_panel/NinePatchRect/sell_item_price_label"
@onready var shop_sell: Control = $"../../.."


func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		visible = false
		amount_text.visible = false
		_slot = null
	else:
		visible = true
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_text.visible = true
		amount_text.text = str(slot.amount)
		_slot = slot


func _on_button_pressed():
	sell_sprite.texture = item_visual.texture
	shop_sell.item = _slot.item
	shop_sell.sell_label.text = amount_text.text
	shop_sell.sell_price_label.text = "$" + str(_slot.item.sell_price)
	shop_sell.sell_sprite.visible = true
	shop_sell.sell_label.visible = true
	shop_sell.sell_price_label.visible = true


func _inv_item_clicked() -> void:
	if _slot and _slot.item and _slot.item.name.contains("seed_") and shop_sell.gc.inv_mode == "seed_select":
		shop_sell.gc.plant_seed(_slot.item.name.replace("seed_", ""),shop_sell.gc.plantable_marker)
