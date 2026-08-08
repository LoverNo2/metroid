extends CharacterBody2D

var gravity_scale := 200
var run_speed := 100
var jump_velocity := -100

# 跳跃手感参数：输入缓冲 + 土狼时间（秒）
const JUMP_BUFFER_TIME := 0.1
const COYOTE_TIME := 0.1

var _jump_buffer_timer := 0.0
var _coyote_timer := 0.0

func _apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y += gravity_scale * delta
	else:
		velocity.y = 0

func _apply_run():
	var direction := Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.x = direction * run_speed

func _jump(delta: float):
		# 跳跃输入缓冲：按下瞬间记录，落地后 0.1 秒内仍可触发跳跃
	if Input.is_action_just_pressed("jump"):
		_jump_buffer_timer = JUMP_BUFFER_TIME
	else:
		_jump_buffer_timer = maxf(_jump_buffer_timer - delta, 0.0)

	# 土狼时间：离开平台后 0.1 秒内仍可起跳
	if is_on_floor():
		_coyote_timer = COYOTE_TIME
	else:
		_coyote_timer = maxf(_coyote_timer - delta, 0.0)

	if _coyote_timer > 0.0 and _jump_buffer_timer > 0.0:
		velocity.y = jump_velocity
		_jump_buffer_timer = 0.0
		_coyote_timer = 0.0

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_apply_run()
	_jump(delta)

	move_and_slide()
