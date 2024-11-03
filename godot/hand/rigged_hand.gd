extends Node3D  # Or the specific type of your model's root node

@onready var skeleton = $Armature/Skeleton3D  # Replace "Skeleton3D" with the actual name of the skeleton node

func _ready():
	if skeleton:
		print("Skeleton found!")
		print_bone_names(skeleton)
	else:
		print("Skeleton not found! Check if the node path is correct.")

func print_bone_names(skeleton):
	var bone_count = skeleton.get_bone_count()
	print("Number of bones: ", bone_count)

	for i in range(bone_count):
		print("Bone ", i, ": ", skeleton.get_bone_name(i))
