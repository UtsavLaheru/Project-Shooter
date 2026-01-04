extends Bullet

func _process(_delta: float) -> void:
	await get_tree().create_timer(despawn_time).timeout
	var game:Game = get_node("/root/game")
	game.bad_ending()
	queue_free()