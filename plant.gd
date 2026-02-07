extends Node2D

@export var growtime: float
@export var textures: Array[Texture2D]
@export var item: InvItem

var growtime_current: float = 0

@onready var sprite: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = textures[0]
	#item = preload("uid://da2qw4adcj5hj")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if growtime_current <= growtime:
		growtime_current += delta
		var div = growtime / (textures.size() - 1)
		#math might be cooked
		var stage = clampi(growtime_current / div, 0, textures.size())
		sprite.texture = textures[stage]
	pass
