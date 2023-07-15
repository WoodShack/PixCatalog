extends Node

# https://pixfavourites.tiddlyhost.com
# "A":"([^"]*)"|#tc-(.*?)\\(?=[^"]*"(?!A":))

func get_fav_data(character_id : int):
	var file_name = "res://Favorites/"+str(character_id)+".json";
	var file = File.new()
	var loaded_data = {}
	var loaded = false
	
	if file.file_exists(file_name):
		file.open(file_name,File.READ)
		var text = file.get_as_text()
		file.close()
		
		var data = parse_json(text)
		if typeof(data) == TYPE_DICTIONARY:
			loaded_data = data
		else:
			printerr("Corrupted favourite json")
			return
			
		loaded_data["id"] = int(loaded_data["id"])
		return loaded_data
		
	else:
		printerr("File does not exist! "+file_name)
		return

func is_favourite(category : String, id : String):
	var fav_data = get_fav_data(Global.get_selected_char())
	category = Global.pad_number(category)
	id = Global.pad_number(id)
	
	if(fav_data["likes"].has(category+"-"+id)):
		return true
	return false

func is_disliked(category : String, id : String):
	var fav_data = get_fav_data(Global.get_selected_char())
	category = Global.pad_number(category)
	id = Global.pad_number(id)
	
	if(fav_data["dislikes"].has(category+"-"+id)):
		return true
	return false
