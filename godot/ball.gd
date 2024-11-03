extends RigidBody3D

class_name ball
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _apply_powerup(powerup:String):
	print(powerup)
	match powerup:
		"multiball":
			_multiball()
		"speed_up":
			_speed_up()
	pass


func _multiball():
	var child_scene = preload("res://ball.tscn")

	var ball_left = child_scene.instantiate()
	var ball_right = child_scene.instantiate()
	var velocity = self.linear_velocity
	var degrees:float = deg_to_rad(45)
	ball_left.transform.origin = self.transform.origin
	ball_right.transform.origin = self.transform.origin
	ball_left.linear_velocity = velocity.rotated(Vector3.UP, degrees)
	ball_right.linear_velocity = velocity.rotated(Vector3.UP, -degrees)
	get_tree().root.add_child(ball_left)
	get_tree().root.add_child(ball_right)
	pass

func _speed_up():
	self.linear_velocity = self.linear_velocity * 10
	
