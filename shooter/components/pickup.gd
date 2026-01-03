extends Area2D
class_name Pickup
var picked_up=false
func _on_body_entered(body: Node2D) -> void:
	if(!picked_up && body is Player):
		picked_up = true
		apply_pickup(body)
		queue_free()

func apply_pickup(player:Player):
	pass
