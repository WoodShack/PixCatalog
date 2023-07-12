extends Node

var selected_category = "00"

func pad_number(var num : int):
	if(num < 10):
		return "0"+str(num)
	return str(num)
