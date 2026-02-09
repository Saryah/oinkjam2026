extends Control

var is_open = false

@onready var inv: Inv = preload("res://Resources/player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var gc: Node2D = $".."


func _ready():
	gc.inv = inv
	inv.update.connect(update_slots)
	update_slots()
	close()


func _process(delta):
	if Input.is_action_just_pressed("tab"):
		if is_open:
			close()
		else:
			open()


func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
		
	for i in gc.seeds_prefabs:
		gc.seeds[i] = inv.count(gc.seeds_prefabs[i]) 

func open():
	visible = true
	is_open = true
	for node in $NinePatchRect/GridContainer.get_children():
		if (node._slot != null and node._slot.item != null and !node._slot.item.sellable) or gc.inv_mode == "":
			node.visible = true
		else:
			node.visible = false



func close():
	visible = false
	is_open = false
	gc.clear_inv_mode()

func inv_close_button_pressed() -> void:
	close()


func _on_inv_ui_btn_button_pressed() -> void:
	if is_open:
		close()
	else:
		open()
