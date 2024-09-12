extends Node3D

var seconds = 0
var minutes = 0

var hs_on = false
var bs_on = false
var miss_on = false

var hs_timer_max = 0.5
var hs_timer = 0
var bs_timer_max = 0.5
var bs_timer = 0
var miss_timer_max = 0.5
var miss_timer = 0

@onready var raycast = $Actors/Player/RayCast3D
@onready var hitbox_head = $"Actors/Enemy/Area Head"
@onready var hitbox_body = $"Actors/Enemy/Area Body"
@onready var indicator_hs = $"Actors/Enemy/Indicator HS"
@onready var indicator_bs = $"Actors/Enemy/Indicator BS"
@onready var indicator_miss = $"Actors/Enemy/Indicator Miss"
@onready var l_timer = $HUD/Timer

func _unhandled_input(event):
	# Shoot
	if event is InputEventMouseButton:
		if event.pressed:
			print("Mouse button pressed!")
			#if raycast.is_on_wall():
			var collider = raycast.get_collider()
			print(collider.name)
			if collider == hitbox_head:
				hs_on = true
			elif collider == hitbox_body:
				bs_on = true
				indicator_bs.rotation_degrees += Vector3(0, 0, randi_range(-360, 360))
			else:
				miss_on = true
				indicator_miss.rotation_degrees += Vector3(0, 0, randi_range(-360, 360))

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hs_timer = hs_timer_max
	indicator_hs.visible = false
	indicator_bs.visible = false
	indicator_miss.visible = false
	
	_python_test()
	#send_to_google_sheets()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer(delta)
	headshot_indicator(delta)
	bodyshot_indicator(delta)
	miss_indicator(delta)
	#if raycast.is_on_wall():
	#	print("RayCast3D is intersecting a physics body")

	
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

func timer(delta):
	if seconds > 60:
		seconds = 0
		minutes += 1
		if minutes > 60:
			minutes = 0
	else:
		seconds += delta
		var m = str(int(minutes))
		if minutes < 10: m = "0" + m
		var s = str(int(seconds))
		if seconds < 10: s = "0" + s
		l_timer.text = m + ":" + s

func send_to_google_sheets():
	#var script_path = "res://scripts/telemetry.py"
	#OS.execute("ping", ["-w", "3", "godotengine.org"], false)
	var script_path = "U://2024//Visualizacion de datos//Repo//visualizacion-datos-git//src//Game//scripts//test3.py"
	OS.execute(script_path, [])

func _python_test():
	OS.execute("U://2024//Visualizacion de datos//Repo//visualizacion-datos-git//src//Game//scriptstest3.py", [])
