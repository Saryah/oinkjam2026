extends Node2D

@export var seeds: Dictionary = {

	"lettuce": 0,
	"tomato": 0,
	"carrot": 0,
	"watermelon": 0,

}

@export var seeds_prefabs: Dictionary = {

	"lettuce": preload("uid://bdvtr7geaon8a"),
	"tomato": preload("uid://bdvtr7geaon8a"), #TODO fix uid
	"carrot": preload("uid://bdvtr7geaon8a"), #TODO fix uid
	"watermelon": preload("uid://bdvtr7geaon8a"), #TODO fix uid

}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func plant_seed(seed: String, plot: Node2D, quantity: int = 1):
	if seeds[seed] > 0:
		seeds[seed] -= 1
		var seed_new = seeds_prefabs[seed].instantiate()
		plot.add_child(seed_new)
		seed_new.position = Vector2.ZERO

func harvest(plot: Node2D):
	var plant = plot.get_child(0)
	
	if plant and plant.growtime_current >= plant.growtime:
		#abandon and murder child
		pass
