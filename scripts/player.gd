extends CharacterBody2D

const GRAVITY := 980.0
const JUMP_VELOCITY := -400.0
const WALK_SPEED := 300.0

const JUMP := "jump"
const LEFT := "left"
const RIGHT := "right"


func _physics_process(_delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY

	# Handle Jump.
	if Input.is_action_just_pressed(JUMP) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle left/right movement.
	var direction := Input.get_axis(LEFT, RIGHT)
	if direction:
		velocity.x = direction * WALK_SPEED
	else:
		velocity.x = 0

	# Handle shooting.
	if Input.is_action_just_pressed("shot"):
		if not $Timer.is_stopped():
			print("Timer is still running!")
		else:
			print("one shot")
			$Timer.start()

	# Move the character.
	move_and_slide()
