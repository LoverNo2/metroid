extends Marker2D

var distance := 50
@export var target: Node2D # 拖动到玩家节点，避免硬编码 get_parent()

func _process(_delta: float) -> void:
	if target == null:
		return
	var aim_dir: Vector2 = (get_global_mouse_position() - target.global_position).normalized()
	position = aim_dir * distance