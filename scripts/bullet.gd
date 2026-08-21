extends Area2D

var shot_direction: Vector2 = Vector2.ZERO
const BULLET_SPEED := 200.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	# Move the bullet.
	position += shot_direction * BULLET_SPEED * _delta


func _on_body_entered(_body: Node2D) -> void:
	queue_free()
