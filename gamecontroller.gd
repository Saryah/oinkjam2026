extends Node2D

@export var seeds: Dictionary = {

	"lettuce": 0,
	"tomato": 0,
	"carrot": 0,
	"watermelon": 0,

}

@export var seeds_prefabs: Dictionary = {

	"lettuce": preload("uid://din0qlkgjjw6t"),
	"tomato": preload("uid://5ulev4pdodoj"),
	"carrot": preload("uid://b4c4f23u8wec6"),
	"watermelon": preload("uid://cncdylephfcq1"),

}

@export var plant_prefabs: Dictionary = {

	"lettuce": preload("uid://bdvtr7geaon8a"),
	"tomato": preload("uid://cib8tng2subt5"),
	"carrot": preload("uid://dgv8geihryml"), #TODO fix uid
	"watermelon": preload("uid://bdvtr7geaon8a"), #TODO fix uid

}

@export var plot_color_normal: Color = Color.html("#00000000")
@export var plot_color_highlighted: Color = Color.html("#0000003a")

@export var inv: Inv
@export var item: InvItem
@export var shop_inv: ShopInv
@export var monies: int = 50

var inv_mode: String
var plantable_marker: Node

@onready var monies_label: Label = $monies_label
@onready var inv_ui: Control = $inv_ui
@onready var shop_buy: Control = $shop_buy


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_monies()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if plantable_marker:
		plantable_marker.get_parent().polygon.color = plot_color_highlighted


func update_monies():
	monies_label.text = "$" + str(monies)


func plant_seed(seed: String, plot: Node2D, quantity: int = 1):
	if seeds[seed] > 0:
		seeds[seed] -= quantity
		var seed_new = plant_prefabs[seed].instantiate()
		plot.add_child(seed_new)
		seed_new.position = Vector2.ZERO
		inv.remove(seeds_prefabs[seed], quantity)
		inv_ui.close()


func harvest(plant: Node2D):
	inv.insert(plant.item)
	plant.get_parent().remove_child(plant)
	plant.queue_free()


func clear_inv_mode():
	if plantable_marker:
		plantable_marker.get_parent().polygon.color = plot_color_normal
	plantable_marker = null
	inv_mode = ""


func buy_item(quantity: int = 1):
	for i in quantity:
		inv.insert(shop_buy.item)
	monies -= (shop_buy.item.buy_price * quantity)
