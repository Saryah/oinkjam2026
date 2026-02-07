extends Label

@onready var gc: Node2D = $"res://gamecontroller.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_monies():
	text ="Monies: " +str(gc.monies)
