extends Node

var Core:Dictionary
var FolderLocation:String
var Folder:String

var ffmpegChecked:bool = false

var state = ConfigFile.new() #Could be used to save, resume, track which mangas you have read

func _ready():
	var file = File.new()
	if !file.file_exists("user://save.dat"):
		state.set_value("save", "latest", [])
		saveState()
	else:
		state.load("user://save.dat")

func load_script(file_path) -> Dictionary:
	var file = File.new()
	if file.open(file_path, File.READ) == OK:
		var text = file.get_as_text()
		var parse = JSON.parse(text)
		var dict = parse.result
		file.close()
		return dict
	else:
		return {}

func saveState():
	state.save("user://save.dat")

func clearState():
	state.set_value("save", "latest", [])
	saveState()

