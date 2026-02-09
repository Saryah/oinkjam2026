extends Node2D

@onready var cutscene01: AnimationPlayer = $cutscene01/AnimationPlayer


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
	"carrot": preload("uid://dgv8geihryml"),
	"watermelon": preload("uid://ddwy4a7wjysy2"),

}

@export var plot_color_normal: Color = Color.html("#00000000")
@export var plot_color_highlighted: Color = Color.html("#0000003a")

@export var inv: Inv
@export var item: InvItem
@export var shop_inv: ShopInv
@export var monies: int = 0
@export var carrot_sold: int = 0
@export var lettuce_sold: int = 0
@export var tomato_sold: int = 0
@export var watermelon_sold: int = 0
@export var lettuce_unlocked: bool = false
@export var tomato_unlocked: bool = false
@export var watermelon_unlocked: bool = false
@export var music_muted: bool = false

var inv_mode: String
var plantable_marker: Node

@onready var sfx_harvest: AudioStreamPlayer2D = $AudioListener2D/harvest
@onready var sfx_button_click: AudioStreamPlayer2D = $AudioListener2D/button_click
@onready var sfx_plant: AudioStreamPlayer2D = $AudioListener2D/plant
@onready var music: AudioStreamPlayer2D = $AudioListener2D/music

@onready var monies_label: Label = $monies_label
@onready var inv_ui: Control = $inv_ui
@onready var shop_buy: Control = $shop_buy
@onready var carrots_sold_label: Label = $carrots_sold_label
@onready var lettuce_sold_label: Label = $lettuce_sold_label
@onready var tomato_sold_label: Label = $tomato_sold_label
@onready var watermelon_sold_label: Label = $watermelon_sold_label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_monies()
	cutscene01.play("cutscene01")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if plantable_marker:
		plantable_marker.get_parent().polygon.color = plot_color_highlighted


func update_monies():
	monies_label.text = "$" + str(monies)
	carrots_sold_label.text = str(carrot_sold)
	lettuce_sold_label.text = str(lettuce_sold)
	tomato_sold_label.text = str(tomato_sold)
	watermelon_sold_label.text = str(watermelon_sold)


func plant_seed(seed: String, plot: Node2D, quantity: int = 1):
	if seeds[seed] > 0:
		seeds[seed] -= quantity
		var seed_new = plant_prefabs[seed].instantiate()
		plot.add_child(seed_new)
		seed_new.position = Vector2.ZERO
		inv.remove(seeds_prefabs[seed], quantity)
		inv_ui.close()
		sfx_plant.playing = true



func harvest(plant: Node2D):
	inv.insert(plant.item)
	plant.get_parent().remove_child(plant)
	plant.queue_free()
	sfx_harvest.playing = true


func clear_inv_mode():
	if plantable_marker:
		plantable_marker.get_parent().polygon.color = plot_color_normal
	plantable_marker = null
	inv_mode = ""


func buy_item(quantity: int = 1):
	for i in quantity:
		inv.insert(shop_buy.item)
	monies -= (shop_buy.item.buy_price * quantity)


func seed_unlock_check():
	if carrot_sold >= 20 and lettuce_unlocked == false:
		shop_inv.shop_insert(seeds_prefabs["lettuce"], 9999999)
		lettuce_unlocked = true
		monies -= 75
		#run cutscene???
	elif lettuce_sold >= 30 and tomato_unlocked == false:
		shop_inv.shop_insert(seeds_prefabs["tomato"], 9999999)
		tomato_unlocked = true
		monies -= 250
		#run cutscene???
	elif tomato_sold >= 50 and watermelon_unlocked == false:
		shop_inv.shop_insert(seeds_prefabs["watermelon"], 9999999)
		watermelon_unlocked = true
		monies -= 750
		#run cutscene???

func _on_mute_button_pressed() -> void:
	sfx_button_click.playing = true
	if !music_muted:
		music_muted = true
		music.volume_linear = 0
	else:
		music_muted = false
		music.volume_linear = 0.65	
	
