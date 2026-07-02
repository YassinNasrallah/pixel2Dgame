extends CharacterBody2D
var is_chating = false
var player_in_chat_zone = false
var player = null
var dialogue_finiched = false

func _on_control_dialogue_finiched() -> void:
	dialogue_finiched = true
	is_chating = false
	$Dialogue.hide()
	return


func _on_chat_det_body_entered(body):
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true
		print('player enter erea')
	
	
func _unhandled_input(event):
	print("zone:", player_in_chat_zone)
	if player_in_chat_zone and event.is_action_pressed("start conversation") and !dialogue_finiched:
		is_chating = true
		$Dialogue.show()
		$Dialogue.start()


func _on_chat_det_body_exited(body):
	player_in_chat_zone = false 
	player = null
	$Dialogue.hide()
