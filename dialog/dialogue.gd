extends Control
signal dialogue_finiched
@export_file("*.json") 
var d_file = "res://dialog/dialogue_sister.json"
var current_dialogue_id = 0
var is_dialogue_finiched = false
var dialogue = []

func _ready():
	$NinePatchRect.visible = false
	
func start():
	if Global.d_active :
		return
	
	
	Global.d_active = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	$NinePatchRect.visible = true
	next_script()
	
	
func load_dialogue():
	var file = FileAccess.open(d_file, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	
	return content
	
func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >=dialogue.size():
		Global.d_active = false
		is_dialogue_finiched = true
		$NinePatchRect.visible = false
		emit_signal("dialogue_finiched")
		return
		
	if Global.d_active:
		$NinePatchRect.visible = true
		$NinePatchRect/Name.text = dialogue[current_dialogue_id]["Name"]
		$NinePatchRect/Text.text = dialogue[current_dialogue_id]["Text"]
	

func _input(event):
		
	if event.is_action_pressed("ui_accept"):
		Global.d_active = true
		is_dialogue_finiched = false
		next_script()
	
