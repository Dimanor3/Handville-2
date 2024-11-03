extends Area3D
@export var power_type: String = "multiball"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("powerup")
	if body is ball:
		body._apply_powerup(power_type)
		self.queue_free()
	pass # Replace with function body.
