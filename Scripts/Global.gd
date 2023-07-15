extends Node

var _save_file = "user://user.json"
var _selected_character : int = 1
var selected_category : String = "00"
var character_images = []

func _ready():
	var file = File.new()
	if !file.file_exists(_save_file):
		_save_user_data()
	
	_load_user_data()
	_preload_character_images()

func set_selected_char(char_id : int):
	if(char_id < 1 or char_id > 26):
		printerr("Invalid character id "+str(char_id))
		return
		
	_selected_character = char_id
	_save_user_data()

func get_selected_char():
	return _selected_character

func pad_number(var num):
	num = int(num)
	if(num < 10):
		return "0"+str(num)
	return str(num)

func _save_user_data():
	var save_dict = {
		"selected_character" : _selected_character
	}
		
	var file = File.new()
	file.open(_save_file, File.WRITE)
	file.store_string(to_json(save_dict))
	file.close()

func _load_user_data():	
	var file = File.new()
	var loaded_data = {}
	var loaded = false
	
	if file.file_exists(_save_file):
		file.open(_save_file, File.READ)
			
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			loaded_data = data
			loaded = true
		else:
			printerr("Corrupted user data")
	else:
		printerr("No user data")
		return
		
	if(loaded):
		_selected_character = int(loaded_data["selected_character"])
		
func _preload_character_images():
	for n in 26:
		character_images.append(
			load("res://Images/Characters/"+str(n+1)+".png"))
