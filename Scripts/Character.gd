extends Control

var _character_id

signal character_selected(character_id)

func set_character(character_id : int):
	_character_id = character_id
	var character_data = Favorites.get_fav_data(character_id)
	
	$"%Icon".texture = Global.character_images[character_id-1]
	$"%Label".text = character_data["name"]

func _on_Button_pressed():
	emit_signal("character_selected",_character_id)
