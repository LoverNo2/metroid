extends CharacterBody2D

var speed := 50
var player: CharacterBody2D
var health := 2


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	player = body


func _physics_process(_delta: float) -> void:
	if player:
		var direction := (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()


func explode():
	$AnimatedSprite2D.hide()
	$Explosion.show()
	$AnimationPlayer.play("explosion")
	await $AnimationPlayer.animation_finished
	queue_free()


func chain_explode():
	for drone in get_tree().get_nodes_in_group("Drones"):
		if (
			drone != self
			and (
				position.distance_to(drone.position)
				< $DetectionArea/CollisionShape2D.shape.radius * 2
			)
		):
			drone.explode()


func _on_collison_area_body_entered(_body: CharacterBody2D) -> void:
	explode()


func _on_detection_area_body_exited(_body: Node2D) -> void:
	player = null


func hit():
	health -= 1
	if health <= 0:
		explode()
