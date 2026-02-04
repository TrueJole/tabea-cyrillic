extends Node

const FILENAME = "user://savefile.json"

var data: Array[int]:
	set(val):
		data = val
		write()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file: FileAccess = FileAccess.open(FILENAME, FileAccess.READ)
	if FileAccess.file_exists(FILENAME):
		print(JSON.to_native(JSON.parse_string(file.get_as_text())))
		data = JSON.to_native(JSON.parse_string(file.get_as_text()))
		print("Load")
	else:
		data.resize(Constants.ELEMENTS)
		print("Default")

func write() -> void:
	var file: FileAccess = FileAccess.open(FILENAME, FileAccess.WRITE)
	file.store_string(JSON.stringify(JSON.from_native(data)))
	print("Write")
