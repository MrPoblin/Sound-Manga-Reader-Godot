extends VBoxContainer

func load_text(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func _on_SpaceGroteskMedium_pressed():
	$"../FontPopup".popup()
	$"../FontPopup/ScrollContainer/OFL".text = load_text("res://Licenses/SpaceGrotesk-Medium.txt")
	
