extends Node

enum SYSTEM {
	WINDOWS = 1,
	UNIX = 2
}

var Core:Dictionary
var FolderLocation:String
var Folder:String
var osType:int

var ffmpegChecked:bool = false

var state = ConfigFile.new() #Could be used to save, resume, track which mangas you have read

func _ready():
	if(OS.get_name() == "Windows"):
		osType = SYSTEM.WINDOWS
	elif(OS.get_name() == "X11" || OS.get_name() == "OSX"):
		osType = SYSTEM.UNIX
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

func to_vorbis(path) -> void:
	OS.execute(Config.config.get_value("storage", "ffmpeg", ""), ["-i", path + ".ogg", path + "_vorbis.ogg",  "-c:a", "libvorbis"])

func to_vorbis_replace(path) -> void:
	to_vorbis(path)
	match osType:
		SYSTEM.WINDOWS:
			pass
#			OS.execute("CMD.exe", ["/C", "del", path + ".ogg"])
#			OS.execute("CMD.exe", ["/C", "ren", path + "_vorbis.ogg", path + ".ogg"])
		SYSTEM.UNIX:
			pass
