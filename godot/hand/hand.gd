extends Node3D

class_name Hand

const NUM_LANDMARKS: int = 21
const HAND_SCALE: float = 30.0

const HAND_LINES_MAPPING = [
	[0, 1], [1, 2], [2, 3], [3, 4], # Thumb
	[0, 5], [5, 6], [6, 7], [7, 8], # Index Finger
	[5, 9], [9, 10], [10, 11], [11, 12], # Middle Finger
	[9, 13], [13, 14], [14, 15], [15, 16], # Ring Finger
	[0, 17], [13, 17], [17, 18], [18, 19], [19, 20], # Pinky
]

var landmark_sphere: PackedScene = preload("res://hand/hand_landmark.tscn")

var hand_landmarks: Array[HandLandmark] = []
var hand_lines: Array[MeshInstance3D] = []
var bones: Array[int] = []
var skeleton
var handz: Node3D
var orientation: String

func _init(hand_bones: Array[int], skeleton_bones, hands: Node3D, orient: String) -> void:
	bones = hand_bones
	skeleton = skeleton_bones
	handz = hands
	orientation = orient

func _ready() -> void:
	_create_hand_landmark_spheres()
	_create_hand_lines()

func _create_hand_landmark_spheres() -> void:
	for i in range(NUM_LANDMARKS):
		var landmark_instance = landmark_sphere.instantiate() as HandLandmark
		landmark_instance.from_landmark_id(i)
		add_child(landmark_instance)
		hand_landmarks.append(landmark_instance)

func _create_hand_lines() -> void:
	for i in HAND_LINES_MAPPING.size():
		var line_instance := MeshInstance3D.new()
		add_child(line_instance)
		hand_lines.append(line_instance)

func _process(_delta: float) -> void:
	_update_hand_lines()

func _update_hand_lines() -> void:
	for i in HAND_LINES_MAPPING.size():
		var mapping = HAND_LINES_MAPPING[i]
		var p0 = hand_landmarks[mapping[0]].global_position
		var p1 = hand_landmarks[mapping[1]].global_position
		LineRenderer.edit_line(hand_lines[i], p0, p1)

func _update_hand_landmark(landmark_id: int, landmark_pos: Vector3) -> void:
	var lm = hand_landmarks[landmark_id]
	lm.target = landmark_pos

func parse_hand_landmarks_from_data(hand_data: Array) -> void:
	# Set the global position of the skeleton if needed (e.g., following a target object)
	 #skeleton.global_transform.origin = <target_position>
	
	var old_pos
	var bone_pos
	var base_pos: Vector3
	var index_palm_pos: Vector3
	var pinky_palm_pos: Vector3
	
	for lm_id in range(NUM_LANDMARKS):
		var lm_data = hand_data[lm_id]
		
		# Process landmark data to get the target position
		var pos_cam = Vector3(lm_data[0], lm_data[1], lm_data[2]) - Vector3.ONE * 0.5
		var pos_xyz = Vector3(-pos_cam[0], -pos_cam[1], pos_cam[2]) * HAND_SCALE
		pos_xyz.z += 12
		
		#if (orientation == "left"):
			#continue
		#else:
			#continue
		
		# Get the current bone's global transform
		#skeleton.set_bone_pose_position(bones[lm_id], pos_xyz)

			
		if (lm_id == 0):
			#skeleton.set_bone_pose_position(bones[lm_id], pos_xyz)
			handz.global_position = pos_xyz
			base_pos = pos_xyz
			
		if (lm_id == 5):
			index_palm_pos = pos_xyz
			
		if (lm_id == 17):
			pinky_palm_pos = pos_xyz


		# Update the visual position of the hand landmark
		_update_hand_landmark(lm_id, pos_xyz)
	
	var index_vector = index_palm_pos - base_pos
	var pinky_vector = pinky_palm_pos - base_pos
	
	var final_cross = pinky_vector.cross(index_vector)
	
	handz.look_at(final_cross)
	#handz.rotate_y(deg_to_rad(90))
	
	#if (orientation == "right"):
		#handz.scale = Vector3(70, 70, 70)
