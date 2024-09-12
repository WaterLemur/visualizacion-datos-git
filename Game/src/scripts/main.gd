extends Node


func _new_game_pressed() -> void:
	Global.state += 1
	Global.already_created = false
