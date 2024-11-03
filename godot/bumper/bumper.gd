extends Area3D

@export var bounciness: float = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body is RigidBody3D:
		var force: Vector3 =  body.transform.origin - self.transform.origin
		body.apply_impulse(force * bounciness)
		ScoreCounter._player_point()
	
