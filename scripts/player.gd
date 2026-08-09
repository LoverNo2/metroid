extends CharacterBody2D

signal shoot(position: Vector2, direction: Vector2)

var gravity_scale := 200
var run_speed := 100
var jump_velocity := -100
var lower_animation
var lower_sprite
var upper_animation
var upper_sprite

func _ready() -> void:
	lower_animation = $LowerTorso/AnimationPlayer
	lower_sprite = $LowerTorso
	upper_animation = $UpperTorso/AnimationPlayer
	upper_sprite = $UpperTorso

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
			lower_sprite.flip_h = false
		else:
			lower_sprite.flip_h = true
		lower_animation.play("jump")
	elif velocity.x != 0:
		if (velocity.x > 0):
			lower_sprite.flip_h = false
		else:
			lower_sprite.flip_h = true
		lower_animation.play("run")
	else:
		lower_animation.play("idle")

func _handle_shoot():
	if Input.is_action_just_pressed("shoot"):
		emit_signal("shoot", position, get_local_mouse_position().normalized())

func _handle_upper_texture():
	var direction := get_local_mouse_position().normalized()
	var angle_degrees := rad_to_deg(direction.angle())
	# 归一化到 0-360，每 45° 一帧，偏移 22.5° 使第 0 帧居中于正右方
	var angle := fmod(angle_degrees + 360 + 22.5, 360)
	upper_sprite.frame = int(angle / 45) % 8

	
func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_move()
	_handle_shoot()
	_handle_upper_texture()

	move_and_slide()
