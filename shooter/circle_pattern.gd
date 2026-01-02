extends Node2D

@export var speed = 0.1
@export var move_speed = 100

func _process(delta: float) -> void:
	$Path2D/PathFollow2D.progress_ratio += speed * delta
	$Path2D/PathFollow2D2.progress_ratio += speed * delta
	$Path2D/PathFollow2D3.progress_ratio += speed * delta
	$Path2D/PathFollow2D4.progress_ratio += speed * delta
	$Path2D/PathFollow2D5.progress_ratio += speed * delta
	$Path2D/PathFollow2D6.progress_ratio += speed * delta
	$Path2D/PathFollow2D7.progress_ratio += speed * delta
	position += transform.y * move_speed * delta
