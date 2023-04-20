extends VBoxContainer

func load_text(path):
	var file = File.new()
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func hide_popup():
	var popup_nodes = get_tree().get_nodes_in_group("popup")
	for i in popup_nodes:
		i.visible = false

func _on_project_repository_pressed():
	OS.shell_open("https://github.com/MrPoblin/Sound-Manga-Reader-Godot")

func _on_SpaceGroteskMedium_pressed():
	$FontPopup.popup()
	$FontPopup/ScrollContainer/OFL.text = load_text("res://Licenses/SpaceGrotesk-Medium.txt")

func _on_og_project_pressed():
	OS.shell_open("https://gitlab.com/papjul/sound-manga-reader/")

func _on_LogoGodot_pressed():
	OS.shell_open("https://godotengine.org/")

func _on_kenney_uipack_pressed():
	OS.shell_open("https://kenney.nl/")
