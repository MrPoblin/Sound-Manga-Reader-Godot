extends Control

onready var ReaderNode = preload("res://Scenes/Reader.tscn")
var font: DynamicFont = load("res://default_font.tres")
export var themeAlpha:float

onready var mouseScheme:int = Config.config.get_value("controls", "mouseScheme", 0)

func _ready() -> void:
	Config.load_volume()
	initTheme()
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

func _on_Main_resized(wait) -> void:
	fontSet(wait)

var isPaused: bool = false
func fontSet(wait: int = false) -> void:
	if (!isPaused):
		isPaused = true
		if(wait):
			yield(get_tree().create_timer(0.2), "timeout")
		isPaused = false
		var newFont: int = int(sqrt(get_viewport_rect().size.y*get_viewport_rect().size.x)/50) #Choose the scale in settings?
		if(font.size != newFont):
			font.size = newFont
			font.outline_size = newFont/18

func initTheme() -> void:
	var modulateColor:Color = Config.config.get_value("color", "panel")
	modulateColor.a = themeAlpha
	var currentTheme = get_theme()
	var styleboxData = {
		"Button": ["normal", "pressed", "hover", "disabled"],
		"LineEdit": ["normal", "read_only"],
		"HSlider": ["slider", "grabber_area", "grabber_area_highlight"]
	}
	for styleType in styleboxData:
		for styleItem in styleboxData[styleType]:
			var styleEdit = currentTheme.get_stylebox(styleItem, styleType)
			styleEdit.modulate_color = modulateColor
			if(styleItem == "grabber_area_highlight"):
				styleEdit.modulate_color.a = styleEdit.modulate_color.a + 0.1
			elif(styleItem == "pressed"):
				styleEdit.modulate_color.a = styleEdit.modulate_color.a + 0.1
			elif(styleItem == "hover"):
				styleEdit.modulate_color.a = styleEdit.modulate_color.a - 0.033
			elif(styleItem == "disabled" || styleItem == "read_only"):
				styleEdit.modulate_color.a = styleEdit.modulate_color.a + 0.28
			currentTheme.set_stylebox(styleItem, styleType, styleEdit)
	set_theme(currentTheme)
