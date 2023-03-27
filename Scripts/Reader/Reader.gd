extends Control

onready var CORE:Dictionary = State.Core
onready var Chapter:String
onready var MusicPath:String = Config.config.get_value("storage", "music") + CORE["soundDir"]
onready var PageNum:int
onready var Pages:Array = CORE["chapters"][Chapter]["pages"]
onready var PageCount:int = CORE["chapters"][Chapter]["pages"].size()
onready var ChapterList:Array = CORE["chapters"].keys()
onready var swapLR:bool = Config.config.get_value("controls", "swapLR")
onready var prevBgm
onready var prevSfx
onready var autoResize:bool = Config.config.get_value("controls", "auto_resize")
onready var longClick:float = Config.config.get_value("controls", "long_click")
onready var mouseScheme:int = Config.config.get_value("controls", "mouseScheme", 0)
var signal_received:bool = false
var doPan:bool


func _ready():
	load_chapter(true)
	$Bg.color = Config.config.get_value("color", "bg")

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_left"):
			if(swapLR):
				next_page()
			else:
				prev_page()
		if event.is_action_pressed("ui_right"):
			if(swapLR):
				prev_page()
			else:
				next_page()
		if event.is_action_pressed("ui_up"):
			prev_page()
		if (event.is_action_pressed("ui_down") || event.is_action_pressed("ui_accept")):
			next_page()
		if event.is_action_pressed("help"):
			$Popup.popup()

func load_chapter(isBeginning):
	if(isBeginning):
		PageNum = 0
	else:
		PageNum = PageCount-1
	change_page(PageNum)

func change_page(num):
	var page:Dictionary = Pages[num]
	var img:String = page["page"]
	var bgm = page["bgm"]
	var se = page["se"]
	var voice:bool = page["voice"]
	$Image.load_image(img, Chapter)
	$Voice.stop()
	if(bgm&&bgm!=prevBgm):
		$Music.set_stream(get_audio(true, MusicPath + "/bgm/" + bgm + ".ogg"))
		$Music.play()
	elif(!bgm):
		$Music.stop()
	if(voice):
		$Voice.set_stream(get_audio(false, State.FolderLocation + "/voice/ch-" + Chapter + "/" + img + ".ogg"))
		$Voice.play()
	if(se&&se!=prevSfx):
		if self.has_node("SFX"):
			$SFX.free()
		var sfx_container = Node.new()
		sfx_container.name = "SFX"
		add_child(sfx_container)
		for id in se:
			var sfx = AudioStreamPlayer.new()
			sfx.bus = "SFX"
			sfx.set_stream(get_audio(true, MusicPath + "/se/" + id + ".ogg"))
			sfx.playing = true
			$SFX.add_child(sfx)
	elif(!se):
		if self.has_node("SFX"):
			$SFX.free()
	prevSfx = se
	prevBgm = bgm

func prev_page():
	PageNum -= 1
	if PageNum < 0:
		var prevIndex = ChapterList.find(Chapter)-1
		if prevIndex > -1:
			Chapter = ChapterList[prevIndex]
			Pages = CORE["chapters"][Chapter]["pages"]
			PageCount = CORE["chapters"][Chapter]["pages"].size()
			load_chapter(false)
		else:
			$"../Menu".visible = true
			self.visible = false
			PageNum += 1
	else:
		change_page(PageNum)
	#print(PageNum)

func next_page():
	PageNum += 1
	if PageNum > PageCount-1:
		var nextIndex = ChapterList.find(Chapter)+1
		if nextIndex < (ChapterList.size()-1):
			Chapter = ChapterList[nextIndex]
			Pages = CORE["chapters"][Chapter]["pages"]
			PageCount = CORE["chapters"][Chapter]["pages"].size()
			load_chapter(true)
		else:
			$"../Menu".visible = true
			self.visible = false
			PageNum -= 1
	else:
		change_page(PageNum)

func _on_Reader_resized():
	if signal_received == false:
		signal_received = true
		return
	print("res")
	$Image.fill_center() #if(autoResize):

func get_audio(loop, path):
	var ogg_file = File.new()
	ogg_file.open(path, File.READ)
	var ogg_data = ogg_file.get_buffer(ogg_file.get_len())
	ogg_file.close()
	var ogg_stream = AudioStreamOGGVorbis.new()
	ogg_stream.data = ogg_data
	if(loop): ogg_stream.loop = true
	return ogg_stream

func _on_Reader_visibility_changed():
	if(!visible&&Config.config.get_value("controls", "mute_on_pause")):
		AudioServer.set_bus_mute(0, true)
	elif(visible&&Config.config.get_value("audio", "master")>0):
		AudioServer.set_bus_mute(0, false)

func _on_Left_pressed():
	if(swapLR):
		next_page()
	else:
		prev_page()

func _on_Right_pressed():
	if(swapLR):
		prev_page()
	else:
		next_page()

func _on_Bg_gui_input(event):
	if event is InputEventMouseButton:
		if (event.button_index == BUTTON_LEFT) || (event.button_index == BUTTON_RIGHT && mouseScheme == 1):
			doPan = true
			var mouse_timer = $Timer
			if event.is_pressed():
				mouse_timer.start(longClick)
			else:
				$Image.isPanning = false
				if mouse_timer.time_left > 0:
					doPan = false
					if(mouseScheme == 0):
						if($Bg.get_local_mouse_position().x < $Bg.rect_size.x/2):
							if(swapLR):
								next_page()
							else:
								prev_page()
						else:
							if(swapLR):
								prev_page()
							else:
								next_page()
					elif(mouseScheme == 1):
						if(event.button_index == BUTTON_LEFT):
							if(swapLR):
								next_page()
							else:
								prev_page()
						else:
							if(swapLR):
								prev_page()
							else:
								next_page()
			mouse_timer = null

func _on_Timer_timeout():
	if(doPan):
		$Image.mouseStart = $Image.get_local_mouse_position()
		$Image.isPanning = true
		$Bg.mouse_default_cursor_shape= Control.CURSOR_MOVE

