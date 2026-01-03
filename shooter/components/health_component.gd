extends Node2D
class_name HealthComponent
#emit when this is destroyed
signal destroyed(position:Vector2)

@export var Max_Health : int = 100
var health : int


func _ready() -> void:
	health = Max_Health

func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= 0:
		destroyed.emit(global_position)
		get_parent().queue_free() 
