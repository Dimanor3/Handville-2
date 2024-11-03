extends Area3D

@export var bounciness: float = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	
	if body is RigidBody3D:
		print("boing")
		var force: Vector3 =  transform.basis.z * -1
		body.linear_velocity = Vector3 (body.linear_velocity.x, body.linear_velocity.y, 0)
		body.apply_impulse(force * bounciness)
	
