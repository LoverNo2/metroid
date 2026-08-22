extends Area2D

var shot_direction: Vector2 = Vector2.ZERO
const BULLET_SPEED := 200.0


func setup(start_position: Vector2, direction: Vector2) -> void:
	position = start_position
	shot_direction = direction


func _physics_process(_delta: float) -> void:
	# Move the bullet.
	position += shot_direction * BULLET_SPEED * _delta


func _on_body_entered(_body: Node2D) -> void:
	queue_free()
