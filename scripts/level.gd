extends Node2D

var bullet_scene := load("res://scenes/bullet.tscn")

func _on_player_shoot(position: Vector2, direction: Vector2):
	var bullet_timer = $Timers/bullet
	if bullet_timer.is_stopped():
		bullet_timer.start()
		var bullet = bullet_scene.instantiate()
		bullet.setup(position, direction)
		$Objects.add_child(bullet)
	else:
		return


func physics_process(delta: float) -> void:
	pass
