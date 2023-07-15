extends Control

func _ready():
	for n in 26:
		var character = load("res://Scenes/Character.tscn").instance()
		character.set_character(n+1)
		character.connect("character_selected",self,"_on_character_selected")
		$"%VBoxContainer".add_child(character)
	_add_bottom_margin()

func _add_bottom_margin():
	var bottomMargin = MarginContainer.new()
	bottomMargin.rect_min_size = Vector2(100,700)
	$"%VBoxContainer".add_child(bottomMargin)
	
func _on_character_selected(character_id : int):
	Global.set_selected_char(character_id)
	get_tree().change_scene("res://Scenes/Main.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
