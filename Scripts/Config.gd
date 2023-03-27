extends Node

var config = ConfigFile.new()

func initConfig():
	config.set_value("audio", "master", 0.5)
	config.set_value("audio", "music", 0.5)
	config.set_value("audio", "sfx", 0.5)
	config.set_value("audio", "voice", 0.5)
	config.set_value("storage", "manga", "")
	config.set_value("storage", "music", "")
	config.set_value("storage", "same", true)
	config.set_value("controls", "swapLR", false)
	config.set_value("controls", "auto_resize", true)
	config.set_value("controls", "mute_on_pause", true)
	config.set_value("controls", "zoom_step", 1.35)
	config.set_value("controls", "long_click", 0.23)
	config.set_value("controls", "mipmaps", false)
	config.set_value("controls", "mouseScheme", 0)
	config.set_value("color", "bind", true)
	randomize()
	var tempCol = Color(randf()*0.6,randf()*0.6,randf()*0.6, 0.9)
	config.set_value("color", "main", tempCol)
	config.set_value("color", "panel", tempCol.lightened(0.12))
	config.set_value("color", "bg", Color.black)
	saveConfig()

func saveConfig():
	config.save("user://config.cfg")

func _ready():
	var file = File.new()
	if !file.file_exists("user://config.cfg"):
		initConfig()
	else:
#		loadConfig()
		config.load("user://config.cfg")
