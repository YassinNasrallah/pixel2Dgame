extends Area2D
var player_in = false




func _on_body_entered(body: Node2D) -> void:
	player_in = true


func _on_body_exited(body: Node2D) -> void:
	player_in = false 
	
func _process(delta):
	if player_in == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://levels/level_1.tscn")
