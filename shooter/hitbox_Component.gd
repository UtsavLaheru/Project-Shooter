extends Area2D
class_name HitboxComponent
@export var health_component : HealthComponent

#Note: Please Don't add Collison shape to external scence or instiate scence directly.

func damange(attack: Attack):
	if health_component:
		health_component.damage(attack)
