extends FileDialog

var isManga:bool

func _on_man_but_sel_pressed():
	isManga=true
	popup()


func _on_mus_but_sel_pressed():
	isManga=false
	popup()


func _on_SelectLocation_dir_selected(dir):
	if(isManga):
		$"%le_storage_manga".text = dir
	else:
		$"%le_storage_music".text = dir
