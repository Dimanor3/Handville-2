extends Node3D

var player_score = 0
@onready var rigged_left_hand: Node3D
@onready var rigged_right_hand: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rigged_left_hand = get_node("/root/World/lefthand")
	rigged_right_hand = get_node("/root/World/righthand")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _update_score(ps) -> void:
	player_score = ps
	
	#if (player_score <= 10):
		#rigged_left_hand.scale.z -= (player_score * 10)
		#rigged_right_hand.scale.z -= (player_score * 10)
	#else:
		#pass
