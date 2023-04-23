extends FileDialog

var isManga:bool

func _on_man_but_sel_pressed():
	self.set_mode(FileDialog.MODE_OPEN_DIR)
	isManga=true
	popup()

func _on_mus_but_sel_pressed():
	self.set_mode(FileDialog.MODE_OPEN_DIR)
	isManga=false
	popup()

func _on_ffmpeg_select_pressed():
	self.set_mode(FileDialog.MODE_OPEN_FILE)
	popup()


func _on_SelectLocation_dir_selected(dir):
	if(isManga):
		$"%le_storage_manga".text = dir
	else:
		$"%le_storage_music".text = dir

func _on_SelectLocation_file_selected(path):
	$"%le_ffmpeg".text = path


