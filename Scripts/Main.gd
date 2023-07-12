extends Control

#var downloadQR = load("res://Scripts/DownloadQR.gd").new()

func _ready():
	#add_child(downloadQR)
	_init_categories()
	
func _init_categories():
	$"%Category1".set_icon(load("res://Images/Icons/meal.png"))
	$"%Category1".set_label("Meals")
	$"%Category1".set_category("00")
	$"%Category1".connect("category",self,"_category_selected")
	
	$"%Category2".set_icon(load("res://Images/Icons/snack.png"))
	$"%Category2".set_label("Snacks")
	$"%Category2".set_category("16")
	$"%Category2".connect("category",self,"_category_selected")
	
	$"%Category3".set_icon(load("res://Images/Icons/box.png"))
	$"%Category3".set_label("Items")
	$"%Category3".set_category("32")
	$"%Category3".connect("category",self,"_category_selected")
	
	$"%Category4".set_icon(load("res://Images/Icons/accessories.png"))
	$"%Category4".set_label("Accessories")
	$"%Category4".set_category("48")
	$"%Category4".connect("category",self,"_category_selected")
	
	$"%Category5".set_icon(load("res://Images/Icons/furniture.png"))
	$"%Category5".set_label("Furniture")
	$"%Category5".set_category("64")
	$"%Category5".connect("category",self,"_category_selected")
	
	$"%Category6".set_icon(load("res://Images/Icons/living.png"))
	$"%Category6".set_label("Livings")
	$"%Category6".set_category("80")
	$"%Category6".connect("category",self,"_category_selected")
	
	$"%Category7".set_icon(load("res://Images/Icons/special.png"))
	$"%Category7".set_label("Special")
	$"%Category7".set_category("96")
	$"%Category7".connect("category",self,"_category_selected")

func _on_CoffeeButton_pressed():
	OS.shell_open("https://ko-fi.com/D1D02EEDN")
	
func _category_selected(category):
	Global.selected_category = category
	get_tree().change_scene("res://Scenes/Browse.tscn")

func _on_HelpButton_pressed():
	$HelpDialog.visible = true
