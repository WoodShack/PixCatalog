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
	
func _on_Button_pressed():
	emit_signal("item_selected",_category,_id)
