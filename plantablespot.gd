extends Area2D

@export var col: int = 0
@export var row: int = 0
@export var seed: String


@onready var gc: Node2D = $"../.."
@onready var marker: Marker2D = $marker
@onready var collision: CollisionPolygon2D = $collision
@onready var polygon: Polygon2D = $polygon


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	polygon.polygon = collision.polygon
	connect("mouse_entered", on_hover)
	connect("mouse_exited", on_unhover)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_hover():
	polygon.color = gc.plot_color_highlighted


func on_unhover():
	polygon.color = gc.plot_color_normal


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#This is what happens when you click a plantable spot
		if marker.get_child_count() == 0:
			gc.plant_seed(seed, marker)
			
		elif marker.get_child_count() == 1 and marker.get_child(0).growtime_current >= marker.get_child(0).growtime:
				gc.harvest(marker.get_child(0)) 
