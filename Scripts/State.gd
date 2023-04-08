extends Node

var Core:Dictionary
var FolderLocation:String

func load_title(file_path, folder_path):
	var file = File.new()
	file.open(file_path, file.READ)
	var text = file.get_as_text()
	var parse = JSON.parse(text)
	var dict = parse.result
	file.close()
	return dict
