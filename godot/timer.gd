extends Timer

var loops = 0
var chance
@export var interval = 1

@onready var hands

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.start(interval)
	hands = get_tree().current_scene.get_node("HandTracking")

func _on_timeout() -> void:
	chance = _randomize_chance()
	
	match loops:
		0:
			print("option 1")
		1, 2, 3, 4, 5:
			if (chance > 50):
				hands._mod_hand_landmarks(_randomize_hand_node(), randi() % 2)
			else:
				hands._mod_hand_landmarks(_randomize_hand_node(), randi() % 2)
		_:
			print("option all")
	
	loops += 1
	
	self.start(interval)
	
func _randomize_chance() -> int:
	return randi_range(1, 100)
	
func _randomize_hand_node() -> int:
	return randi_range(0, 20)
