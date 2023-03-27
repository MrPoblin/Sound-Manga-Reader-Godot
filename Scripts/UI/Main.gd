extends Control

onready var ReaderNode = preload("res://Scenes/Reader.tscn")

onready var mouseScheme:int = Config.config.get_value("controls", "mouseScheme", 0)

func _ready():
	load_bus(0, Config.config.get_value("audio", "master"))
	load_bus(1, Config.config.get_value("audio", "music"))
	load_bus(2, Config.config.get_value("audio", "sfx"))
	load_bus(3, Config.config.get_value("audio", "voice"))


func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("reload"):
			get_tree().reload_current_scene()
		if event.is_action_pressed("ui_cancel"):
			if self.has_node("Reader"):
				$Reader.visible = !$Reader.visible
				$Menu.visible = !$Menu.visible
		if event.is_action_pressed("fullscreen"):
			OS.window_fullscreen = !OS.window_fullscreen
		if event.is_action_pressed("borderless"):
			OS.window_borderless = !OS.window_borderless
	if event is InputEventMouse:
		if event.is_action_pressed("ui_cancel") && self.has_node("Reader") && (mouseScheme == 0):
			$Reader.visible = !$Reader.visible
			$Menu.visible = !$Menu.visible

func init_reader(chapter):
	#print(chapter)
	if self.has_node("Reader"):
		$Reader.free()
	var newReader = ReaderNode.instance()
	newReader.CORE = State.Core
	newReader.Chapter = chapter
	add_child(newReader)
	$Menu.visible = false
	$Reader.visible = true

func load_bus(id, linear):
	if(linear>0): 
		AudioServer.set_bus_mute(id, false)
		AudioServer.set_bus_volume_db(id, 20 * (log(linear)/log(10)))
	else: 
		AudioServer.set_bus_mute(id, true)
