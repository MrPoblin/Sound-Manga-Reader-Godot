extends HBoxContainer
 
var ffmpeg_main := Thread.new()

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
#	var folderArray: Array
#	var dir := Directory.new()
	
	ffmpeg_main.start(self, "conversion_process", action)
	$conversion_progress.popup_centered()
	
#	ffmpeg_main.wait_to_finish()
#	conversion_process(action)
#	ffmpeg_main.wait_to_finish()
	match action:
		"copy":
			pass
		"replace":
			pass

func conversion_process(action) -> void:
	
	pass


func _on_conversion_progress_about_to_show():
	while(ffmpeg_main.is_active() && ffmpeg_main.is_alive()):
		pass
	ffmpeg_main.wait_to_finish()
