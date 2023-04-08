extends VBoxContainer

onready var TemplateButton = load("res://Scenes/UI/MangaButtonTemplate.tscn")

func _ready():
	var manga_path :String = Config.config.get_value("storage", "manga")
	check_all_folders(manga_path)
	if(self.get_child_count() <= 1):
		$no_manga.visible = true

func check_all_folders(folder_path: String):
	var dir = Directory.new()
	if dir.open(folder_path) == OK:
		dir.list_dir_begin()
		var file_path = dir.get_next()
		while file_path != "":
			if dir.current_is_dir() && (file_path != ".") && (file_path != ".."):
				#print(file_path)
				find_json(Config.config.get_value("storage", "manga")+file_path)
			file_path = dir.get_next()
		dir.list_dir_end()

func find_json(folder_path):
	var dir = Directory.new()
	if dir.open(folder_path) == OK:
		dir.list_dir_begin()
		var file_path = dir.get_next()
		while file_path != "":
			if(file_path == "script.json"):
				load_title(folder_path+"/"+file_path, folder_path)
				#print(json_dict["title"])
			file_path = dir.get_next()
		dir.list_dir_end()

func load_title(file_path, folder_path):
	var file = File.new()
	file.open(file_path, file.READ)
	var text = file.get_as_text()
	var parse = JSON.parse(text)
	var dix = parse.result
	file.close()
	add_button(dix["title"], dix, folder_path)

func add_button(title, dict, folder_path):
	$no_manga.visible = false
	var NewButton = TemplateButton.instance()
	NewButton.name = title
	NewButton.text = title
	NewButton.Dict = dict
	NewButton.location = folder_path
	NewButton.visible = true
	add_child(NewButton)
