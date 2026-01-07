extends Enemy
class_name BossEnemy

@export var bubble_bullet_scene:PackedScene = preload("res://components/Bubble_Bullet.tscn")
@export var lowest_y_position:float = 500
@export var minimum_rotation:float = -60
@export var maximum_rotation:float = 60

func _physics_process(delta: float) -> void:
	if player != null:
		var direction:Vector2 = (player.global_position - global_position).normalized()
		var delta_position = direction * speed * delta

		#stop boss moving too far down the screen
		if(delta_position.y+global_position.y > lowest_y_position):
			delta_position.y=0
			#increase speed as we're not moving in the y direction
			delta_position=delta_position.normalized() * speed * delta
		move_and_collide(delta_position)
		look_at(to_global(to_local(player.global_position).rotated(-PI/2)))
		if(global_rotation_degrees<minimum_rotation):
			global_rotation_degrees=minimum_rotation
		elif(global_rotation_degrees>maximum_rotation):
			global_rotation_degrees=maximum_rotation
	