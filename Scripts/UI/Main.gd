extends Control

onready var ReaderNode = preload("res://Scenes/Reader.tscn")
var font = load("res://default_font.tres")

onready var mouseScheme:int = Config.config.get_value("controls", "mouseScheme", 0)

func _ready() -> void:
	Config.load_volume()
	
	if(Config.config.get_value("controls", "onTop")): 
		OS.set_window_always_on_top(true)
	else: 
		OS.set_window_always_on_top(false)


func _input(event) -> void:
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

func init_reader(chapter, page: int = 0) -> void:
	if self.has_node("Reader"):
		$Reader.free()
	var newReader = ReaderNode.instance()
	newReader.Chapter = chapter
	add_child(newReader)
	$Reader.load_chapter(page)
	$Menu.visible = false
	$Reader.visible = true

func _on_Main_resized() -> void:
	var newFont: int = int(sqrt(get_viewport_rect().size.y*get_viewport_rect().size.x)/50)
	if(font.size != newFont):
		font.size = newFont
		font.outline_size = newFont/18
