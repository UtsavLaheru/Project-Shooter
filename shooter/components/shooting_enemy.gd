extends CharacterBody2D
@onready var player = get_node("/root/game/Player")
@export var bubble_bullet_scene:PackedScene = preload("res://components/Bubble_Bullet.tscn")
@export var speed: float = 250
@export var enemy_hit_damage:int = 10
var Shoot_Player: bool = false
var Can_Shoot: bool = true
@export var fire_rate: float = 0.5
#var enemy_is_inside_player: bool = false

func _physics_process(delta: float) -> void:
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		move_and_collide(Vector2(direction.x,direction.y) * speed * delta)
		look_at(to_global(to_local(player.global_position).rotated(PI/2)))
		
	if Shoot_Player == true:
		shoot()
	#print(player)
	#move_and_slide()

func shoot():
	if Can_Shoot == true:
		var bubble_bullet:Bubble_Bullet = bubble_bullet_scene.instantiate()
		get_node("/root/game").add_child(bubble_bullet)
		bubble_bullet.transform = $Shoot_Point.global_transform
		Can_Shoot = false
		$Timer.set_wait_time(fire_rate)
		$Timer.start()
	#audio_manager.playFireBulletStream(bubble_bullet.global_position)

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	if area is HitboxComponent && area.get_parent().name == "Player":
		var hitbox : HitboxComponent = area
		#enemy_is_inside_player = true
		var attack = Attack.new()
		attack.attack_damage = enemy_hit_damage
		hitbox.damage(attack)
		#print(hitbox.health_component.health)
		var audio_manager:AudioManager = get_tree().get_first_node_in_group("audio_manager")
		audio_manager.playPlayerHitStream(global_position)
	


func _on_shooting_range_area_entered(_area: Area2D) -> void:
	Shoot_Player = true


func _on_shooting_range_area_exited(_area: Area2D) -> void:
	Shoot_Player = false


func _on_timer_timeout() -> void:
	Can_Shoot = true
