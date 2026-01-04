extends Node2D

@export var speed = 0.5
var direction = 1
var target = 1
@export var move_speed = 85
func _ready() -> void:
	direction = $Path2D/PathFollow2D.progress_ratio

func _process(delta: float) -> void:
	$Path2D/PathFollow2D.progress_ratio = direction 
	if direction < target:
		target = 1
		direction += speed * delta
	elif direction > target:
		direction -= speed * delta
		target = 0
	
	position += transform.y * move_speed * delta


func _on_queue_free_component_delete_yourself() -> void:
	queue_free()
