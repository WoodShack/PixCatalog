extends Node

var _http_request
var _urls = []
var _file_names = []
var _request_num = 0
var _category = ""
var _id = ""

func _ready():
	_populate_urls()
	_download_next_qr_code()

func _populate_urls():
	for i in 7:
		var category = Global.pad_number(i*16)
		for j in 100:
			var id = Global.pad_number(j)
			var url = _get_url(category,id)
			_file_names.append(category+"_"+id+".png")
			_urls.append(url)
			
func _download_next_qr_code():
	print("Downloading "+_urls[_request_num]+"...");
	
	_http_request = HTTPRequest.new()
	add_child(_http_request)
	_http_request.connect("request_completed", self, "_http_request_completed")
	
	var error = _http_request.request(_urls[_request_num],PoolStringArray(),false)
	if error != OK:
		push_error("An error occurred in the HTTP request.")

func _get_url(var category : String, var id: String):
	return "http://mrblinky.net/tama/pix/download/qrcode/tc-"+category+"-"+id+".png";
	
func _http_request_completed(result, response_code, headers, body):
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image.")
	else:
		image.save_png("user://qr/"+_file_names[_request_num])
	
	_request_num += 1
	remove_child(_http_request)
	_http_request.queue_free()
	_download_next_qr_code()
