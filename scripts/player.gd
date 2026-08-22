extends CharacterBody2D

const BULLET_SCENE := preload("res://scenes/bullet.tscn")

const GRAVITY := 10
const JUMP_VELOCITY := -200
const WALK_SPEED := 100

const TORSE_SPRITE_MAP := {
	Vector2i(-1, -1): 5,
	Vector2i(-1, 0): 4,
	Vector2i(-1, 1): 3,
	Vector2i(0, -1): 6,
	Vector2i(0, 1): 2,
	Vector2i(1, 0): 0,
	Vector2i(1, -1): 7,
	Vector2i(1, 1): 1
}

const JUMP := "jump"
const LEFT := "left"
const RIGHT := "right"
var animation_player

func _ready() -> void:
	animation_player = $AnimationPlayer


func _physics_process(_delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY

	# Handle Jump.
	if Input.is_action_just_pressed(JUMP) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle left/right movement.
	var direction := Input.get_axis(LEFT, RIGHT)
	if direction < 0:
		$Leg.flip_h = true
	elif direction > 0:
		$Leg.flip_h = false
	if direction:
		if is_on_floor():
			animation_player.play("run")
		velocity.x = direction * WALK_SPEED
	else:
		if is_on_floor():
			animation_player.play("idle")
		velocity.x = 0

	if not is_on_floor():
		animation_player.play("jump")

	var mouse_local_position: Vector2i = Vector2i(get_local_mouse_position().normalized().round())
	$Torse.frame = TORSE_SPRITE_MAP.get(mouse_local_position, 0)
	

	# Handle shooting.
	if Input.is_action_just_pressed("shot"):
		if not $Timer.is_stopped():
			print("Timer is still running!")
		else:
			var tween = get_tree().create_tween()
			tween.tween_property($Cross/Sprite2D, "scale", Vector2(0.3, 0.3), 0.1)
			tween.tween_property($Cross/Sprite2D, "scale", Vector2(0.15, 0.15), 0.1)
			var shot_direction := (get_global_mouse_position() - position).normalized()
			var bullet := BULLET_SCENE.instantiate()
			bullet.setup(position, shot_direction)
			get_tree().current_scene.add_child(bullet)
			$Timer.start()

	# Move the character.
	move_and_slide()
