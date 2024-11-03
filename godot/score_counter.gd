extends Node3D

var player_score: int = 0
var cpu_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("game_manager")
	pass # Replace with function body.

func _player_point():
	player_score += 1
	print(player_score)
	pass
	
func _cup_point():
	cpu_score += 1
	print(cpu_score)
	pass
