extends Control

func _ready():
	_load_category(Global.selected_category)

func _load_category(category : String):
	if(category == "128"):
		_load_favourites()
		return
	
	if(category == "144"):
		_load_dislikes()
		return
	
	var icons = _get_category_icons("res://Images/Icons/"+category)
	for icon in icons:
		var split = icon.split("-")
		var item = load("res://Scenes/Item.tscn").instance()
		var icon_texture = load("res://Images/Icons/"+category+"/"+icon);
		var id =  Global.pad_number(int(split[0]))
		var item_name = "";
		
		item.connect("item_selected",self,"_on_item_selected")
		
		for n in split.size():
			if(n == 0):
				continue
			item_name += " "+split[n].replace(".png","")
		
		$"%VBoxContainer".add_child(item)
		item.set_item(icon_texture, category, id, item_name)
		
	_add_bottom_margin()
	
func _load_favourites():
	var character_data = Favorites.get_fav_data(Global.get_selected_char())
	if(character_data["likes"].size() == 0):
		$"%NoItems".visible = true
		return
	
	for like in character_data["likes"]:
		var category = Global.pad_number(like.split("-")[0])
		var id = Global.pad_number(like.split("-")[1])
		var item = load("res://Scenes/Item.tscn").instance()
		var icon_texture = load(_get_item_icon_path(category,id))
		var item_name = _get_item_name(category,id)
		
		$"%VBoxContainer".add_child(item)
		item.set_item(icon_texture, category, id, item_name)
		item.connect("item_selected",self,"_on_item_selected")
	
	_add_bottom_margin()

func _load_dislikes():
	var character_data = Favorites.get_fav_data(Global.get_selected_char())
	if(character_data["dislikes"].size() == 0):
		$"%NoItems".visible = true
		return
		
	for like in character_data["dislikes"]:
		var category = Global.pad_number(like.split("-")[0])
		var id = Global.pad_number(like.split("-")[1])
		var item = load("res://Scenes/Item.tscn").instance()
		var icon_texture = load(_get_item_icon_path(category,id))
		var item_name = _get_item_name(category,id)
		
		$"%VBoxContainer".add_child(item)
		item.set_item(icon_texture, category, id, item_name)
		item.connect("item_selected",self,"_on_item_selected")
	
	_add_bottom_margin()
	
func _get_item_icon_path(category : String, id : String):
	var icons = _get_category_icons("res://Images/Icons/"+category)
	for icon in icons:
		var split = icon.split("-")
		if(Global.pad_number(int(split[0])) == id):
			return "res://Images/Icons/"+category+"/"+icon
	
	printerr("item icon not found: "+category+"-"+id)
	return ""
	
func _get_item_name(category : String, id : String):
	var icons = _get_category_icons("res://Images/Icons/"+category)
	for icon in icons:
		var item_name = "";
		var split = icon.split("-")
		
		for n in split.size():
			if(n == 0):
				continue
			item_name += " "+split[n].replace(".png","")
		
		if(Global.pad_number(int(split[0])) == id):
			return item_name
	
	printerr("item name not found: "+category+"-"+id)
	return ""

func _add_bottom_margin():
	var bottomMargin = MarginContainer.new()
	bottomMargin.rect_min_size = Vector2(100,700)
	$"%VBoxContainer".add_child(bottomMargin)

func _get_category_icons(path : String):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.ends_with(".import"):
			files.append(file.replace(".import",""))

	dir.list_dir_end()

	return files
	
func _on_item_selected(category : String ,id : String):
	$"%QR".texture = load("res://Images/QR Codes/"+category+"_"+id+".png")
	$"%QR".visible = true
	$"%VBoxContainer".visible = false

func _on_BackButton_pressed():
	if($"%QR".visible):
		$"%QR".visible = false
		$"%VBoxContainer".visible = true
		return
	
	get_tree().change_scene("res://Scenes/Main.tscn")
