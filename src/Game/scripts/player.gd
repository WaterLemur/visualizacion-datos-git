extends CharacterBody3D

var speed = 5.0
const JUMP_VELOCITY = 4.5
var sens_x = 0.25
var sensitivity = 1
var d = 1

@onready var camera = $Camera3D
@onready var collision = $CollisionShape3D

func _process(delta: float) -> void:
	d = delta
	_player_movement(delta)
	pass

		
func _player_movement(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		position.x -= speed * delta
		print("Move: Left")
	if Input.is_action_pressed("move_right"):
		position.x += speed * delta
		print("Move: Right")
	if Input.is_action_pressed("move_forward"):
		position.z -= speed * delta
		print("Move: Forward")
	if Input.is_action_pressed("move_backwards"):
		position.z += speed * delta
		print("Move: Backwards")


func _unhandled_input(event):
	# Rotation
	if event is InputEventMouseMotion:
	# Calculate the rotation based on mouse movement
		rotate_y(-event.relative.x * sensitivity * sens_x * d)
		rotate_x(-event.relative.y * sensitivity * sens_x * d)
		rotation.z = 0
