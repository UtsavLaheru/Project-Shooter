extends Pickup
@export var invincibility_period:float = 5
func apply_pickup(player:Player):
	if(player):
		var hitbox_component:HitboxComponent=player.find_children("*","HitboxComponent",false)[0]
		hitbox_component.invincibility += invincibility_period
	else:
		print_debug("invalid/missing player variable passed to invincibility pickup")


func _on_queue_free_component_delete_yourself() -> void:
	queue_free()
