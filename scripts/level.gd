extends Node2D

var bullet_scene := load("res://scenes/bullet.tscn")

func _on_player_shoot(_position: Vector2, _direction: Vector2):
	var bullet_timer = $Timers/bullet
	if bullet_timer.is_stopped():
		bullet_timer.start()
		var bullet = bullet_scene.instantiate()
		bullet.setup(_position, _direction)
		$Objects.add_child(bullet)
	else:
		return


func _physics_process(_delta: float) -> void:
	pass
