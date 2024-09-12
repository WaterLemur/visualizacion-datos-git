extends CharacterBody3D

# Variables ---------------------------------------------------------
const JUMP_VELOCITY = 4.5
var speed = 5.0

var sensitivity = 1
var sens_x = 0.25
var d
# References --------------------------------------------------------
@onready var camera = $Camera3D


# Functions ---------------------------------------------------------
func _process(delta: float) -> void:
	d = delta
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()


# -------------------------------------------------------------------
# Camera Rotation
func _unhandled_input(event):
	# Rotation
	if event is InputEventMouseMotion:
	# Calculate the rotation based on mouse movement
		rotate_y(-event.relative.x * sensitivity * sens_x * d)
		camera.rotate_x(-event.relative.y * sensitivity * sens_x * d)
		rotation.z = 0
# -------------------------------------------------------------------
