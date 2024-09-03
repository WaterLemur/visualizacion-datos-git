extends Node3D

var sens_x = 0.25
var sensitivity = 1
var d = 1


var hs_on = false
var bs_on = false
var miss_on = false

var hs_timer_max = 0.5
var hs_timer = 0
var bs_timer_max = 0.5
var bs_timer = 0
var miss_timer_max = 0.5
var miss_timer = 0

@onready var player = $Actors/Player
@onready var raycast = $Actors/Player/RayCast3D
@onready var hitbox_head = $"Actors/Enemy/Area Head"
@onready var hitbox_body = $"Actors/Enemy/Area Body"
@onready var indicator_hs = $"Actors/Enemy/Indicator HS"
@onready var indicator_bs = $"Actors/Enemy/Indicator BS"
@onready var indicator_miss = $"Actors/Enemy/Indicator Miss"

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hs_timer = hs_timer_max
	indicator_hs.visible = false
	indicator_bs.visible = false
	indicator_miss.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	d = delta
	headshot_indicator(delta)
	bodyshot_indicator(delta)
	miss_indicator(delta)
	#if raycast.is_on_wall():
	#	print("RayCast3D is intersecting a physics body")
func _unhandled_input(event):
	# Rotation
	if event is InputEventMouseMotion:
	# Calculate the rotation based on mouse movement
		player.rotate_y(-event.relative.x * sensitivity * sens_x * d)
		player.rotate_x(-event.relative.y * sensitivity * sens_x * d)
		player.rotation.z = 0
	# Shoot
	if event is InputEventMouseButton:
		if event.pressed:
			print("Mouse button pressed!")
			#if raycast.is_on_wall():
			var collider = raycast.get_collider()
			print(collider)
			if collider == hitbox_head:
				hs_on = true
			elif collider == hitbox_body:
				bs_on = true
				indicator_bs.rotation_degrees += Vector3(0, 0, randi_range(-360, 360))
			else:
				miss_on = true
				indicator_miss.rotation_degrees += Vector3(0, 0, randi_range(-360, 360))

func headshot_indicator(delta: float):
	if hs_on == true:
		if hs_timer <= 0:
			hs_on = false
			indicator_hs.visible = false
			hs_timer = hs_timer_max
		else:
			indicator_hs.visible = true
			hs_timer -= delta
			
func bodyshot_indicator(delta: float):
	if bs_on == true:
		if bs_timer <= 0:
			bs_on = false
			indicator_bs.visible = false
			bs_timer = bs_timer_max
		else:
			indicator_bs.visible = true
			bs_timer -= delta
			
func miss_indicator(delta: float):
	if miss_on == true:
		if miss_timer <= 0:
			miss_on = false
			indicator_miss.visible = false
			miss_timer = miss_timer_max
		else:
			indicator_miss.visible = true
			miss_timer -= delta
