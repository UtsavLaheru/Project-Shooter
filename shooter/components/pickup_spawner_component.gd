extends Node2D
class_name PickupSpawnerComponent
@export var available_pickups:Array[PackedScene]
@export var pickup_probabilities:Array[float]
@export var no_pickup_probability:float=0
var probability_sum
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	if(available_pickups.size()!=pickup_probabilities.size()):
		print_debug("Array size mismatch in ",name)
	probability_sum = no_pickup_probability
	for i in range(0,pickup_probabilities.size()):
		probability_sum+=pickup_probabilities[i]
		
func spawn_pickup(spawn_position:Vector2,free_on_finish:bool=false):
	var roll = randf()*probability_sum
	var acc=0
	print_debug("Rolled for pickup with ",roll)
	for i in range(0,pickup_probabilities.size()):
		acc+=pickup_probabilities[i]
		if(roll < acc):
			var spawn:Pickup=available_pickups[i].instantiate()
			spawn.global_position=spawn_position
			get_tree().root.add_child.call_deferred(spawn)
			break

	if(free_on_finish):
		queue_free()
