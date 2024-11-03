extends Node3D

@onready var animationController: AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animationController = self.get_node("/AnimationPlayer") as AnimationPlayer
	
	match randi_range(1, 3):
		1:
			animationController.play("Armature_001|Armature_001|mixamo_com|Layer0")
		2:
			animationController.play("Armature_001|Armature_002|mixamo_com|Layer0")
		3:
			animationController.play("Armature_001|Armature|mixamo_com|Layer0")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
