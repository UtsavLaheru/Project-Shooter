extends "res://components/pickup.gd"
@export var weapon_type:Player.WeaponType=Player.WeaponType.MISSILE
func apply_pickup(player:Player):
	player.switch_weapon(weapon_type)