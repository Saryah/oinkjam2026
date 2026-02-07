extends Control

var is_open = false

@onready var inv: Inv = preload("res://Resources/player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var gc: Node2D = $".."

		
func _ready():
	#filter()
	gc.inv = inv
	inv.update.connect(update_slots)
	update_slots()
	close()

func _process(delta):
	if Input.is_action_just_pressed("s"):
		if is_open:
			close()
		else:
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
	is_open = true


func close():
	visible = false
	is_open = false


func inv_close_button_pressed() -> void:
	close()
