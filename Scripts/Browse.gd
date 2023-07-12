extends Control

func _ready():
	_load_category(Global.selected_category)

func _load_category(category : String):
	var icons = _get_category_icons("res://Images/Icons/"+category)
	for icon in icons:
		var split = icon.split("-")
		var item = load("res://Scenes/Item.tscn").instance()
		var iconTexture = load("res://Images/Icons/"+category+"/"+icon);
		var id =  Global.pad_number(int(split[0]))
		var itemName = "";
		
		item.connect("item_selected",self,"_on_item_selected")
		
		for n in split.size():
			if(n == 0):
				continue
			itemName += " "+split[n].replace(".png","")
		
		$"%VBoxContainer".add_child(item)
		item.set_item(iconTexture, category, id, itemName)
		
	_add_bottom_margin()

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
