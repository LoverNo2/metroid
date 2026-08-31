extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween := create_tween()
	tween.set_loops()
	tween.tween_property($Lights/PointLight2D2, "energy", 1.2, 0.7)
	tween.tween_property($Lights/PointLight2D2, "energy", 0.8, 0.7)