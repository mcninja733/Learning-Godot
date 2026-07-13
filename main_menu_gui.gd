extends Control



# Changes the scene to the main scene for most of the things to be handled there
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_game.tscn")


# Currently a placeholder for testing things not actually in a 3D space.
func _on_testing_button_pressed() -> void:
	print(VariableHandler.race_gacha())
	


# Quits the game plain and up.
func _on_quit_button_pressed() -> void:
	get_tree().quit()
