extends Area2D
@export var bullet_speed: float = 1000
@export var bullet_damange = 10
@export var despawn_time = 2

func _physics_process(delta: float) -> void:
	position += -transform.y * bullet_speed * delta

func _process(delta: float) -> void:
	await get_tree().create_timer(despawn_time).timeout
	queue_free()
	


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent && area.body_entered:
		var hitbox: HitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damange = bullet_damange
		hitbox.damange(attack)
		#print(attack.attack_damange)
		queue_free()
