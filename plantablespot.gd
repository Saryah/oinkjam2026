extends Area2D

@export var row: int = 0
@export var col: int = 0
@export var seed: String

@onready var gc: Node2D = $"../.."
@onready var marker: Marker2D = $marker
@onready var collision: CollisionPolygon2D = $collision
@onready var polygon: Polygon2D = $polygon


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	polygon.polygon = collision.polygon
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#This is what happens when you click a plantable spot
		if marker.get_child_count() == 0:
			gc.plant_seed(seed, marker)
