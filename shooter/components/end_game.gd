extends Control
@export var success_controls:Control
@export var failure_controls:Control
@export var lose_controls:Control
@export var statistics_label:Label
@export var game_scene:String ="res://levels/game.tscn"
@export var stats_text_format:String = "Shots fired: %s\nEnemies killed: %s"
func _ready() -> void:
	success_controls.visible = Statistics.game_state == Statistics.State.WON
	failure_controls.visible = Statistics.game_state == Statistics.State.MISSED_BOSS
	lose_controls.visible = Statistics.game_state == Statistics.State.DEAD
	populate_stats()

func populate_stats():
	statistics_label.text = stats_text_format % [str(Statistics.shot_count), str(Statistics.kill_count)]
	#statistics_label.text = "Shots fired: %s\nEnemies killed: %s" % ["1", "2"]

func _on_retry_button_pressed() -> void:
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(game_scene)
