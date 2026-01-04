extends Node
class_name WeaponComponent
@export var bullet_scene:PackedScene = preload("res://components/bullet.tscn")
@export var infinite_ammo:bool = true
@export var ammo_remaining:int = 1
@export var shoot_point:Node2D
var audio_manager:AudioManager

func _ready() -> void:
	audio_manager = get_tree().get_first_node_in_group("audio_manager")

func shoot():
	if(infinite_ammo || ammo_remaining > 0):
		if(!infinite_ammo): ammo_remaining -= 1

		var bullet:Bullet = bullet_scene.instantiate()
		get_node("/root/game").add_child(bullet)
		bullet.transform = shoot_point.global_transform
		audio_manager.playFireBulletStream(bullet.global_position)