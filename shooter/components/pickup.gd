extends Area2D
class_name Pickup
var picked_up=false
func _on_body_entered(body: Node2D) -> void:
	if(!picked_up && body is Player):
		picked_up = true
		apply_pickup(body)
		var audio_manager:AudioManager = get_tree().get_first_node_in_group("audio_manager")
		audio_manager.playPickupStream(global_position)
		queue_free()

func apply_pickup(player:Player):
	pass
