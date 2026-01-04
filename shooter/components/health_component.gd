extends Node2D
class_name HealthComponent
#emit when this is destroyed
signal destroyed(position:Vector2)

@export var Max_Health : int = 100
@export var Invulnerable = false
var health : int


func _ready() -> void:
	health = Max_Health

func damage(attack: Attack):
	if(Invulnerable): return

	health -= attack.attack_damage
	
	if health <= 0:
		if(!get_parent() is Player):
			Statistics.kill_count += 1
		else:
			Statistics.game_state=Statistics.State.DEAD
		destroyed.emit(global_position)
		get_parent().queue_free() 
