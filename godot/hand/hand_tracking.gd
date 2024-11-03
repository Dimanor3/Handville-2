extends Node3D

const PORT: int = 4242

var server: UDPServer

var left_hand: Hand
var right_hand: Hand

var lefty: Array[String]
var righty: Array[String]

var leftyBones: Array[int]
var rightyBones: Array[int]

@onready var rigged_left_hand
@onready var rigged_right_hand
@onready var skeleton_left
@onready var skeleton_right
@onready var bone_name
@onready var bone_index

func _ready() -> void:
	server = UDPServer.new()
	server.listen(PORT)
	rigged_left_hand = get_tree().current_scene.get_node("lefthand")
	rigged_right_hand = get_tree().current_scene.get_node("righthand")
	skeleton_left = rigged_left_hand.get_node("Armature/Skeleton3D")
	skeleton_right = rigged_right_hand.get_node("Armature/Skeleton3D")
	
	lefty = [
		"hand.L",
		"thumb.01.L",
		"thumb.02.L",
		"thumb.03.L",
		"thumb.03.L_end",
		"palm.01.L",
		"finger_index.01.L",
		"finger_index.02.L",
		"finger_index.03.L",
		"palm.02.L",
		"finger_middle.01.L",
		"finger_middle.02.L",
		"finger_middle.03.L",
		"palm.03.L",
		"finger_ring.01.L",
		"finger_ring.02.L",
		"finger_ring.03.L",
		"palm.04.L",
		"finger_pinky.01.L",
		"finger_pinky.02.L",
		"finger_pinky.03.L",
	]
	
	righty = [
		"hand.R",
		"thumb.01.R",
		"thumb.02.R",
		"thumb.03.R",
		"thumb.03.R_end",
		"palm.01.R",
		"finger_index.01.R",
		"finger_index.02.R",
		"finger_index.03.R",
		"palm.02.R",
		"finger_middle.01.R",
		"finger_middle.02.R",
		"finger_middle.03.R",
		"palm.03.R",
		"finger_ring.01.R",
		"finger_ring.02.R",
		"finger_ring.03.R",
		"palm.04.R",
		"finger_pinky.01.R",
		"finger_pinky.02.R",
		"finger_pinky.03.R",
	]
	
	set_bones()
	
	left_hand = _create_new_hand(rightyBones, skeleton_left, rigged_left_hand, "left")
	right_hand = _create_new_hand(rightyBones, skeleton_right, rigged_right_hand, "right")
	
func set_bones():
	for l in lefty:
		leftyBones.append(skeleton_left.find_bone(l))
		
	for r in righty:
		rightyBones.append(skeleton_right.find_bone(r))

func _create_new_hand(bones: Array[int], skeleton, hands: Node3D, orientation) -> Hand:
	var hand_instance := Hand.new(bones, skeleton, hands, orientation)
	add_child(hand_instance)
	return hand_instance

func _parse_hands_from_packet(data: PackedByteArray) -> Dictionary:
	var json_string = data.get_string_from_utf8()
	var json = JSON.new()
	
	var error = json.parse(json_string)
	assert(error == OK)
	
	var data_received = json.data
	assert(typeof(data_received) == TYPE_DICTIONARY)
	
	return data_received

func _process(_delta: float) -> void:
	server.poll()
	if server.is_connection_available():
		var peer = server.take_connection()
		var data = peer.get_packet()
		var hands_data = _parse_hands_from_packet(data)
		
		if hands_data["left"] != null:
			left_hand.parse_hand_landmarks_from_data(hands_data["left"])
			
		if hands_data["right"] != null:
			right_hand.parse_hand_landmarks_from_data(hands_data["right"])
