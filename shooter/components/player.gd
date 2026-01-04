extends CharacterBody2D
class_name Player
@export var speed :float = 200
var CanShoot: bool = true
@export var fire_rate: float = 0.5
@export var bullet_scene:PackedScene = preload("res://components/fire_bullet.tscn")
@export var weapon_components:Dictionary[WeaponType,WeaponComponent]
@export var active_weapon_type = WeaponType.FIRE
var screen_size
var audio_manager:AudioManager

enum WeaponType {FIRE,MISSILE}

func _ready() -> void:
	print("Bad Apple, Ying and Yang, Good and Bad, Pure and Evil, And Then We Are Here...")
	screen_size = get_viewport_rect().size
	print(screen_size)
	audio_manager = get_tree().get_first_node_in_group("audio_manager")

func switch_weapon(new_weapon:WeaponType,add_ammo:int=0):
	active_weapon_type = new_weapon
	if(add_ammo>0):
		weapon_components[active_weapon_type].ammo_remaining += add_ammo

func movement():
	velocity = Input.get_vector("Left","Right","Up","Down") * speed
	move_and_slide()
	#Clamping the positions So, it doesn't go out of bound.
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	#Shooting
	if Input.is_action_pressed("Fire"):
		if CanShoot == true:
			$Timer.set_wait_time(fire_rate)  #Delay Bullet
			$Timer.start()
			shoot()
			CanShoot = false

func shoot():
	weapon_components[active_weapon_type].shoot()


func _physics_process(_delta: float) -> void:
	movement()


func _on_timer_timeout() -> void:
	CanShoot = true


func _on_player_health_component_destroyed(_position: Vector2) -> void:
	audio_manager.playPlayerDeathStream(global_position)
