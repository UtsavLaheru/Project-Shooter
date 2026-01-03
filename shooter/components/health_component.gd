extends Node2D
class_name HealthComponent
@export var Max_Health : int = 100
var health : int


func _ready() -> void:
	health = Max_Health

func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= 0:
		if(get_parent() is Player):
			var audio_manager:AudioManager = get_tree().get_first_node_in_group("audio_manager")
			audio_manager.playPlayerDeathStream(global_position)
		get_parent().queue_free() 
