extends HBoxContainer
 

func _ready():
	$op_ffmpeg.add_item ( "Disabled", 0 )
	$op_ffmpeg.add_item ( "Copy", 1 )
	$op_ffmpeg.add_item ( "Replace", 2 )
	$b_ffmpeg_convert/convert_popup.get_ok().visible = false
	$b_ffmpeg_convert/convert_popup.add_button("Replace", true, "replace")
	$b_ffmpeg_convert/convert_popup.add_button("Copy", false, "copy")

func _on_b_ffmpeg_convert_pressed() -> void:
	$b_ffmpeg_convert/convert_popup.popup_centered()

func _on_convert_popup_custom_action(action) -> void:
	$b_ffmpeg_convert/convert_popup.hide()
	var mangaPath: String = Config.config.get_value("storage", "manga", OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS) + "/")
	var musicPath: String = Config.config.get_value("storage", "music", OS.get_system_dir(OS.SYSTEM_DIR_DOWNLOADS) + "/")
	var ffmpegPath: String
	if(Config.checkFFmpeg($"%le_ffmpeg".text)):
		ffmpegPath = $"%le_ffmpeg".text
	elif(Config.checkFFmpeg(Config.config.get_value("storage", "ffmpeg", ""))):
		ffmpegPath = Config.config.get_value("storage", "ffmpeg", "")
	else: 
		$ffmpeg_error_popup.popup_centered()
		return
	
	match action:
		"copy":
			pass
		"replace":
			pass
