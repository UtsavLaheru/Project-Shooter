extends Area2D
class_name Bullet
@export var bullet_speed: float = 1000
@export var bullet_damage = 10
@export var despawn_time = 2
var audio_manager:AudioManager
func _ready() -> void:
	audio_manager = get_tree().get_first_node_in_group("audio_manager")

func _physics_process(delta: float) -> void:
	position += -transform.y * bullet_speed * delta

func _process(_delta: float) -> void:
	await get_tree().create_timer(despawn_time).timeout
	queue_free()
	


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent && area.body_entered:
		var hitbox: HitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = bullet_damage
		hitbox.damage(attack)
		#print(attack.attack_damage)
		audio_manager.playBulletHitStream(global_position)
		queue_free()
