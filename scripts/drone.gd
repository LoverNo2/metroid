extends CharacterBody2D

var speed := 50
var player: CharacterBody2D

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	player = body

func _physics_process(_delta: float) -> void:
	if player:
		var direction := (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	player = null
	velocity = Vector2.ZERO