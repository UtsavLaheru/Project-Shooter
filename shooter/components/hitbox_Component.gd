extends Area2D
class_name HitboxComponent
@export var health_component : HealthComponent
@export var on_hit_invincibility_period: float = 0
var invincibility = 0
@export var sprite:Sprite2D
var normal_modulate_colour:Color
@export var invincibility_flash_colour:Color=Color.GRAY
@export var invincibility_flash_per_second:float = 2
var flash_period

func _ready() -> void:
	if(sprite):
		normal_modulate_colour=sprite.modulate
		flash_period=1/invincibility_flash_per_second

#Note: Please Don't add Collision shape to external scene or instantiate scene directly.
func damage(attack: Attack):
	if health_component:
		if(is_invincible()): 
			return
		health_component.damage(attack)
		if(health_component.health>0):
			invincibility=on_hit_invincibility_period
		if(get_parent() is Player):
			var tree = get_tree()
			if(tree):
				var audio_manager:AudioManager = tree.get_first_node_in_group("audio_manager")
				audio_manager.playPlayerHitStream(global_position)
		

func _process(delta: float) -> void:
	if(invincibility>0):
		invincibility -= delta
		invincibility_flash()

func invincibility_flash():
	if(sprite):
		if(invincibility<=0):
			invincibility=0
			sprite.modulate = normal_modulate_colour
		else:
			var cycle =( cos(invincibility*2*PI*invincibility_flash_per_second)+1 )/2
			sprite.modulate=normal_modulate_colour.lerp(invincibility_flash_colour,cycle)

	pass

func is_invincible():
	return invincibility>0
