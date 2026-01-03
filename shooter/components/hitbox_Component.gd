extends Area2D
class_name HitboxComponent
@export var health_component : HealthComponent
#var invensablitiy = 0.5

#Note: Please Don't add Collison shape to external scence or instiate scence directly.
func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)

#func invensible():
	#if get_parent().name == "Player":
		#$CollisionShape2D.collision.disabled = true
