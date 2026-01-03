extends CharacterBody2D
@onready var player = get_node("/root/game/Player")
@export var speed: float = 250
@export var enemydamage:int = 10 

func _physics_process(delta: float) -> void:
	pass
	#if player != null:
		#var direction = (player.global_position - global_position).normalized()
		#move_and_collide(Vector2(direction.x,direction.y) * speed * delta)
		#
		#
	##print(player)
	#move_and_slide()


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	pass
	#if area is HitboxComponent:
		#var hitbox : HitboxComponent = area
		#
		#var attack = Attack.new()
		#attack.attack_damange = enemydamage
		#hitbox.damange(attack)
