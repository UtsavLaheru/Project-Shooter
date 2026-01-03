extends CharacterBody2D
@onready var player = get_node("/root/game/Player")
@export var speed: float = 250
@export var enemy_hit_damage:int = 10
#var enemy_is_inside_player: bool = false

func _physics_process(delta: float) -> void:
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		move_and_collide(Vector2(direction.x,direction.y) * speed * delta)
		
	#print(player)
	#move_and_slide()


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent && area.get_parent().name == "Player":
		var hitbox : HitboxComponent = area
		#enemy_is_inside_player = true
		var attack = Attack.new()
		attack.attack_damage = enemy_hit_damage
		hitbox.damage(attack)
		print(hitbox.health_component.health)
		var audio_manager:AudioManager = get_tree().get_first_node_in_group("audio_manager")
		audio_manager.playPlayerHitStream(global_position)


func _on_hitbox_component_area_exited(area: Area2D) -> void:
	#enemy_is_inside_player = false
	pass
