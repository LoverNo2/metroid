extends Area2D

var speed := 5
var direction := Vector2()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(pos: Vector2, drec: Vector2):
	position = pos + drec * 15
	direction = drec


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	position.x += direction.x * speed
	position.y += direction.y * speed
	# 子弹超出游戏范围
	var viewport_rect = get_viewport_rect().size
	if position.x < 0 or position.x > viewport_rect.x or position.y < 0 or position.y > viewport_rect.y:
		queue_free()

func _on_body_entered(_body: Node2D):
	queue_free()
