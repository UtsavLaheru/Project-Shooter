extends "res://components/pickup.gd"
@export var weapon_type:Player.WeaponType=Player.WeaponType.MISSILE
func apply_pickup(player:Player):
	player.switch_weapon(weapon_type)


func _on_queue_free_component_delete_yourself() -> void:
	queue_free()
