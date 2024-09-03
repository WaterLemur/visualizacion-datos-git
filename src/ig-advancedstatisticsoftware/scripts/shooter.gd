extends Node3D

var sens_x = 0.25
var sensitivity = 1
var d = 1
@onready var player = $Actors/Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	d = delta

func _unhandled_input(event):
	if event is InputEventMouseMotion:
	# Calculate the rotation based on mouse movement
		player.rotate_y(-event.relative.x * sensitivity * sens_x * d)
		player.rotate_x(-event.relative.y * sensitivity * sens_x * d)
		player.rotation.z = 0
