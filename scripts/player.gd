extends CharacterBody2D

signal shoot(position: Vector2, direction: Vector2)

var gravity_scale := 200
var run_speed := 100
var jump_velocity := -100
var animation
var sprite

func _ready() -> void:
	animation = $AnimationPlayer
	sprite = $Sprite2D

func _apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y += gravity_scale * delta
	else:
		velocity.y = 0

func _handle_move():
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = direction * run_speed

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity

	if not is_on_floor():
		if (velocity.x > 0):
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		animation.play("jump")
	elif velocity.x != 0:
		if (velocity.x > 0):
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		animation.play("run")
	else:
		animation.play("idle")

func _handle_shoot():
	if Input.is_action_just_pressed("shoot"):
		emit_signal("shoot", position, get_local_mouse_position().normalized())

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_move()
	_handle_shoot()
		
	move_and_slide()
