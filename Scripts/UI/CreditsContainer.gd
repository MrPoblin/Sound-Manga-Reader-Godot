extends VBoxContainer

func load_text(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func _on_SpaceGroteskMedium_pressed():
	$FontPopup.popup()
	$FontPopup/ScrollContainer/OFL.text = load_text("res://Licenses/SpaceGrotesk-Medium.txt")

func _on_CreditsContainer_resized():
	print(get_viewport_rect())


func _on_Credits_resized():
	print(get_viewport_rect())
