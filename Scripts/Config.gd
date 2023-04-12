extends Node

var config = ConfigFile.new()

func initConfig():
	config.set_value("audio", "master", 0.5)
	config.set_value("audio", "music", 0.5)
	config.set_value("audio", "sfx", 0.5)
	config.set_value("audio", "voice", 0.5)
	config.set_value("storage", "manga", OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS) + "/")
	config.set_value("storage", "music", OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS) + "/")
	config.set_value("storage", "same", true)
	config.set_value("controls", "swapLR", false)
	config.set_value("controls", "auto_resize", true)
	config.set_value("controls", "mute_on_pause", true)
	config.set_value("controls", "zoom_step", 1.35)
	config.set_value("controls", "long_click", 0.2)
	config.set_value("controls", "mipmaps", false)
	config.set_value("controls", "mouseScheme", 0)
	config.set_value("controls", "onTop", false)
	config.set_value("controls", "uiScale", 50)
	config.set_value("color", "bind", true)
	randomize()
	var tempCol = Color(randf(),randf(),randf(), 1.05)*0.9
	config.set_value("color", "main", tempCol)
	if(tempCol.get_luminance()>0.5):
		config.set_value("color", "panel", tempCol.darkened((tempCol.get_luminance()-0.5)*0.24))
	else:
		config.set_value("color", "panel", tempCol.lightened(tempCol.get_luminance()*0.24))
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

func load_volume():
	load_bus(0, Config.config.get_value("audio", "master"))
	load_bus(1, Config.config.get_value("audio", "music"))
	load_bus(2, Config.config.get_value("audio", "sfx"))
	load_bus(3, Config.config.get_value("audio", "voice"))

func load_bus(id, linear):
	if(linear>0): 
		AudioServer.set_bus_mute(id, false)
		AudioServer.set_bus_volume_db(id, 20 * (log(linear)/log(10)))
	else: 
		AudioServer.set_bus_mute(id, true)
