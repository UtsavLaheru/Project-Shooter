extends Node2D

#var parent
var Despawn_Time: float = 15
#Oh it's Not Good Name And Add this signal to instance root node and "queue_free" to emitted_signal
signal Delete_Yourself()

func _ready() -> void:
	#parent = get_parent()
	$Timer.set_wait_time(Despawn_Time)
	$Timer.start()


func _on_timer_timeout() -> void:
	emit_signal("Delete_Yourself")
