extends Node2D

var current_scene

func _unhandled_input(event):
	if event.is_action_pressed("restart"):
		if current_scene == null:
			current_scene = get_node("3Groups")
		current_scene.queue_free()

		var new_scene_load := preload("res://3_groups.tscn")
		var new_scene = new_scene_load.instantiate()

		add_child(new_scene)
		current_scene = new_scene
