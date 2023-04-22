extends GridContainer


func _ready():
	update_values()
	separate()


func update_values():
	$le_storage_manga.text = Config.config.get_value("storage", "manga", OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS) + "/")
	$le_storage_music.text = Config.config.get_value("storage", "music", OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS) + "/")
	$le_ffmpeg.text = Config.config.get_value("storage", "ffmpeg", "")
	$s_master.value = clamp(Config.config.get_value("audio", "master", 0.5), 0, 1)
	$s_music.value = clamp(Config.config.get_value("audio", "music", 0.5), 0, 1)
	$s_sfx.value = clamp(Config.config.get_value("audio", "sfx", 0.5), 0, 1)
	$s_voice.value = clamp(Config.config.get_value("audio", "voice", 0.5), 0, 1)
	$LocationGrid/c_same.pressed = Config.config.get_value("storage", "same", true)
	$OtherGrid/c_swap_lr.pressed = Config.config.get_value("controls", "swapLR", false)
	$OtherGrid/c_auto_res.pressed = Config.config.get_value("controls", "auto_resize", true)
	$s_zoom.value = clamp(Config.config.get_value("controls", "zoom_step", 1.35), 1, 2)
	$OtherGrid4/s_long_click.value = clamp(Config.config.get_value("controls", "long_click", 0.1), 0.001, 1) * 1000
	$OtherGrid/c_use_mipmaps.pressed = Config.config.get_value("controls", "mipmaps", false)
	$ColorGrid/cp_main.color = Config.config.get_value("color", "main", Color.black)
	$ColorGrid/cp_panel.color = Config.config.get_value("color", "panel", Color.black.lightened(0.12))
	$ColorGrid/cp_bg.color = Config.config.get_value("color", "bg", Color.black)
	$OtherGrid3/c_bind_col.pressed = Config.config.get_value("color", "bind", true)
	$OtherGrid3/c_mute_on_pause.pressed = Config.config.get_value("controls", "mute_on_pause", true)
	$OtherGrid4/op_scheme.select(Config.config.get_value("controls", "mouseScheme", 0)) 
	$OtherGrid3/c_on_top.pressed = Config.config.get_value("controls", "onTop", false)
	$s_ui_scale.value = Config.config.get_value("controls", "uiScale", 51)


func _on_c_same_toggled(button_pressed):
	if(button_pressed):
		$le_storage_music.text = $le_storage_manga.text
		$le_storage_music.editable = false
		$LocationGrid/mus_but_sel.disabled = true
	else:
		$le_storage_music.editable = true
		$LocationGrid/mus_but_sel.disabled = false


func _on_SettingSave_pressed():
	if($LocationGrid/c_same.pressed):
		$le_storage_music.text = $le_storage_manga.text
	var temp:String
	Config.config.set_value("audio", "master", $s_master.value)
	Config.config.set_value("audio", "music", $s_music.value)
	Config.config.set_value("audio", "sfx", $s_sfx.value)
	Config.config.set_value("audio", "voice", $s_voice.value)
	temp = $le_storage_manga.text.replace("\\", "/")
	if(temp):
		if(temp[temp.length()-1] != '/'):
			temp += "/"
	Config.config.set_value("storage", "manga", temp)
	temp = $le_storage_music.text.replace("\\", "/")
	if(temp):
		if(temp[temp.length()-1] != '/'):
			temp += "/"
	Config.config.set_value("storage", "ffmpeg", $le_ffmpeg.text.replace("\\", "/"))
	Config.config.set_value("storage", "music", temp)
	Config.config.set_value("storage", "same", $LocationGrid/c_same.pressed)
	Config.config.set_value("controls", "swapLR", $OtherGrid/c_swap_lr.pressed)
	Config.config.set_value("controls", "auto_resize", $OtherGrid/c_auto_res.pressed)
	Config.config.set_value("color", "bind", $OtherGrid3/c_bind_col.pressed)
	Config.config.set_value("color", "main", $ColorGrid/cp_main.color)
	if($OtherGrid3/c_bind_col.pressed):
		if($ColorGrid/cp_main.color.get_luminance()>0.5):
			Config.config.set_value("color", "panel", $ColorGrid/cp_main.color.darkened(($ColorGrid/cp_main.color.get_luminance()-0.5)*0.24))
		else:
			Config.config.set_value("color", "panel", $ColorGrid/cp_main.color.lightened($ColorGrid/cp_main.color.get_luminance()*0.24))
	else:
		Config.config.set_value("color", "panel", $ColorGrid/cp_panel.color)
	Config.config.set_value("color", "bg", $ColorGrid/cp_bg.color)
	Config.config.set_value("controls", "mute_on_pause", $OtherGrid3/c_mute_on_pause.pressed)
	Config.config.set_value("controls", "zoom_step", $s_zoom.value)
	Config.config.set_value("controls", "long_click", $OtherGrid4/s_long_click.value / 1000)
	Config.config.set_value("controls", "mipmaps", $OtherGrid/c_use_mipmaps.pressed)
	Config.config.set_value("controls", "mouseScheme", $OtherGrid4/op_scheme.get_selected())
	Config.config.set_value("controls", "onTop", $OtherGrid3/c_on_top.pressed)
	Config.config.set_value("controls", "uiScale", $s_ui_scale.value)
	Config.config.save("user://config.cfg")
	if(Config.config.get_value("storage", "manga", "") == "banana/") : #monke
		Config.config.set_value("color", "bind", false)
		Config.config.set_value("color", "main", Color("e0b020"))
		Config.config.set_value("color", "panel", Color("e0b020").lightened(0.24))
		Config.config.set_value("color", "bg", Color("392b00"))
	update_values()
	get_tree().reload_current_scene()


func _on_s_master_value_changed(value):
	Config.load_bus(0, value)
	if(Config.config.get_value("controls", "mute_on_pause")): 
		AudioServer.set_bus_mute(0, true)

func _on_s_music_value_changed(value):
	Config.load_bus(1, value)

func _on_s_sfx_value_changed(value):
	Config.load_bus(2, value)

func _on_s_voice_value_changed(value):
	Config.load_bus(3, value)

func separate() -> void:
	var childNum: int = self.get_child_count()
	var children = self.get_children()
	var num: int = 1
	for child in children:
		if(num == 2):
			var newSep = HSeparator.new()
			self.add_child_below_node(child, newSep)
			newSep = HSeparator.new()
			self.add_child_below_node(child, newSep)
			num = 0
		num += 1

var scaleChanged:bool = false
func _on_s_ui_scale_value_changed(value):
	var MainNode = get_tree().get_root().get_node("Main")
	MainNode.setFont(0.15, value)
	scaleChanged = true

var isRunning:bool = false
func _on_Settings_resized():
	if(scaleChanged && !isRunning):
		isRunning = true
		yield(get_tree().create_timer(0.2), "timeout")
		$s_ui_scale.value = Config.config.get_value("controls", "uiScale", 51)
		isRunning = false
