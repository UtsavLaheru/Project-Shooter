extends Node2D

var x_axis : float
var patterns_x_axis : float
@export var Basic_Enemy:PackedScene = preload("res://components/enemy.tscn")
@export var Circle_Pattern_enemy:PackedScene = preload("res://components/Circle_Pattern.tscn")
@export var Swingy_Pattern_enemy:PackedScene = preload("res://components/swingy_pattern.tscn")
@export var Shooting_Enemy:PackedScene = preload("res://components/Shooting_enemy.tscn")
@export var Boss_Enemy:PackedScene = preload("res://components/boss_enemy.tscn")

@onready var Spawn_Point:Node2D = $Spawn_Point
var min_Spawn_Point:float
var max_Spawn_Point:float
var patterns_min_Spawn_Point:float
var patterns_max_Spawn_Point:float
var choice:int
var random_spawn
var random_spawn2
var CanSpawn: bool = true
var parent_group
var super_parent
var player:Player
@export var Spawn_Delay: float = 5

func _ready() -> void:
	print("Keep Going, Keep Going, We'll Keep fight On and On and On")
	min_Spawn_Point = $Spawn_Point/min_Spawn_Point.position.x
	max_Spawn_Point = $Spawn_Point/max_Spawn_Point.position.x
	patterns_min_Spawn_Point = $Pattern_Spawn_Point/min_Spawn_Point.position.x
	patterns_max_Spawn_Point = $Pattern_Spawn_Point/max_Spawn_Point.position.x
	player = $Player
	#Spawn_Boss()

func _process(_delta: float) -> void:
	if player != null:
		Spawn()
	#print(x_axis)

func Spawn_Boss():
	#boss is large, so always spawn in the middle
	var x_pos = (min_Spawn_Point+max_Spawn_Point)/2.0
	var boss:Enemy = Boss_Enemy.instantiate()
	boss.global_position=Vector2(x_pos,Spawn_Point.global_position.y)
	get_node(".").add_child(boss)



func Spawn():
	if CanSpawn == true:
		x_axis = randf_range(min_Spawn_Point,max_Spawn_Point)
		random_spawn = Vector2(x_axis,Spawn_Point.position.y)
		patterns_x_axis = randf_range(patterns_min_Spawn_Point,patterns_max_Spawn_Point)
		random_spawn2 = Vector2(patterns_x_axis,$Pattern_Spawn_Point.position.y)
		#This is For Testing in future, We need to make it Time Based Difficulty (Remeber).
		choice = randi_range(0,3)
		
		print(choice)
		
		# Choice's System.
		if choice == 0:
			var enemy = Basic_Enemy.instantiate()
			get_node(".").add_child(enemy)
			Delay()
			enemy.global_position = random_spawn
		elif choice == 1:
			var circle_pattern = Circle_Pattern_enemy.instantiate()
			get_node(".").add_child(circle_pattern)
			Delay()
			circle_pattern.global_position = random_spawn2
			print(circle_pattern.global_position)
		elif choice == 2:
			var swingy_pattern = Swingy_Pattern_enemy.instantiate()
			get_node(".").add_child(swingy_pattern)
			Delay()
			swingy_pattern.global_position = random_spawn2
		elif choice == 3:
			var shooting_enemy = Shooting_Enemy.instantiate()
			get_node(".").add_child(shooting_enemy)
			Delay()
			shooting_enemy.global_position = random_spawn
		#print(choice)

func Delay():
	CanSpawn = false
	$Timer.set_wait_time(Spawn_Delay)
	$Timer.start()

func _on_timer_timeout() -> void:
	CanSpawn = true







#Yeah This Out Bound Of method didn't work.
#Note:Don't use "area.get_parent().queue_free()" directly (Stupid Me), Alway's use group's for Freeing Stuff.
#use group for adding pattern instead of using "and" operator (Remeber).
#Yeah I Remebered
