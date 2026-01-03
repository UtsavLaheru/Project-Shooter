extends Node2D

var x_axis : int
var patterns_x_axis : int
@export var Enemy:PackedScene = preload("res://components/enemy.tscn")
@export var Circle_Pattern_enemy:PackedScene = preload("res://components/Circle_Pattern.tscn")
var min_Spawn_Point
var max_Spawn_Point
var patterns_min_Spawn_Point
var patterns_max_Spawn_Point
var choice
var random_spawn
var random_spawn2
var CanSpawn: bool = true
var parent_name
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

func _process(delta: float) -> void:
	if player != null:
		Spawn()
	#print(x_axis)
	
func Spawn():
	if CanSpawn == true:
		x_axis = randi_range(min_Spawn_Point,max_Spawn_Point)
		random_spawn = Vector2(x_axis,$Spawn_Point.position.y)
		patterns_x_axis = randi_range(patterns_min_Spawn_Point,patterns_max_Spawn_Point)
		random_spawn2 = Vector2(patterns_x_axis,$Pattern_Spawn_Point.position.y)
		choice = randi_range(0,3)
		print(choice)
		# Choice's System.
		if choice == 0:
			var enemy = Enemy.instantiate()
			get_node(".").add_child(enemy)
			Delay()
			enemy.global_position = random_spawn
		elif choice == 1:
			var circle_pattern = Circle_Pattern_enemy.instantiate()
			get_node(".").add_child(circle_pattern)
			Delay()
			circle_pattern.global_position = random_spawn2
			print(circle_pattern.global_position)
		#print(choice)

func Delay():
	CanSpawn = false
	$Timer.set_wait_time(Spawn_Delay)
	$Timer.start()

func _on_timer_timeout() -> void:
	CanSpawn = true


func _on_out_of_bound_area_entered(area: Area2D) -> void:
	parent_name = area.get_parent().name
	if parent_name == "Circle_Enemy":    #use group for adding pattern instead of using "and" operator (Remeber).
		super_parent = area.get_parent().get_parent().get_parent().get_parent()
		super_parent.queue_free()
	area.get_parent().queue_free()
	
	
