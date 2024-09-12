extends Node

var intro = preload("res://scenes/intro.tscn").instantiate()
var main = preload("res://scenes/main.tscn").instantiate()
var game = preload("res://scenes/game.tscn").instantiate()

var timer = 0.0
var maxTimer = 2.0
var timerSpeed = 1.0
var state = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = maxTimer
	# var instance = intro.instantiate()
	add_child(intro)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer <= 0:
		if state > 2:
			return
		else: state += 1
		
		timer = maxTimer
		if state == 0:
			_load_intro()
		elif state == 1:
			_load_main()
		elif state == 2:
			_load_game()
	else: timer -= timerSpeed * delta

func _load_intro():
	remove_child(game)
	add_child(intro)


	
func _load_main():
	remove_child(intro)
	add_child(main)

func _load_game():
	remove_child(main)
	add_child(game)

	
