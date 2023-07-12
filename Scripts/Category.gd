extends Control

var _category = "";
signal category(category)

func set_icon(icon : Texture):
	$"%Icon".texture = icon
	
func set_label(text : String):
	$"%Label".text = text

func set_category(category : String):
	_category = category

func _on_Button_pressed():
	emit_signal("category",_category)
