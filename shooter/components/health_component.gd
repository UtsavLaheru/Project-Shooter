extends Node2D
class_name HealthComponent
@export var Max_Health : int = 100
var health : int


func _ready() -> void:
	health = Max_Health

func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= 0:
		get_parent().queue_free() 
