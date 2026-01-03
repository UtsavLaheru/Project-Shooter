extends Node2D

var parent
var Despawn_Time: float = 10

#Working In Progress.

func _ready() -> void:
	parent = get_parent()
	$Timer.set_wait_time(Despawn_Time)
	$Timer.start()


func _on_timer_timeout() -> void:
	parent.queue_free()
