extends Control

var _category
var _id

signal item_selected(category, id)

func _ready():
	pass

func set_item(icon : Texture, category : String, id : String, label : String):
	$"%Icon".texture = icon
	_category = category
	_id = id
	$"%Label".text = label
	
	_check_favourite()
	_check_dislike()
	
func _on_Button_pressed():
	emit_signal("item_selected",_category,_id)
	
func _check_favourite():
	if(Favorites.is_favourite(_category,_id)):
		$Favourite.visible = true
	else:
		$Favourite.visible = false

func _check_dislike():
	if(Favorites.is_disliked(_category,_id)):
		$Dislike.visible = true
	else:
		$Dislike.visible = false
