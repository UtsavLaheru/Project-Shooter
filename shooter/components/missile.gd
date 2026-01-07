extends Bullet
#for one-shotting boss

func _process(_delta: float) -> void:
	await get_tree().create_timer(despawn_time).timeout
	bad_ending() # the missile missed everything
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		print_debug("missile hit ",area.get_parent().name)
		var success = true
		if(!area.get_parent() is BossEnemy):
			success = false # we didn't use the missile to hit the boss
			

		var hitbox = area as HitboxComponent
		var healthComponent = hitbox.health_component
		
		if(healthComponent.Invulnerable || healthComponent.health > bullet_damage):
			success = false # the missile hit the boss, but didn't kill it
			
		handle_hit(area)
		
		if(success):
			good_ending()
		else:
			bad_ending()
		queue_free.call_deferred()
	

func good_ending():
	var game:Game = get_node("/root/game")
	game.win()

func bad_ending():
	var game:Game = get_node("/root/game")
	game.bad_ending()