extends VBoxContainer

onready var TemplateButton = load("res://Scenes/UI/MangaButtonTemplate.tscn")
onready var manga_path :String = Config.config.get_value("storage", "manga")

func _ready():
	var folders:Array = check_all_folders(manga_path)
	folders = array_with_script(manga_path, folders)
	for folder in folders:
		var dict = State.load_script(manga_path+folder+"/script.json")
		add_button(dict["title"], dict, manga_path, folder)
	if(self.get_child_count() <= 1):
		$no_manga.visible = true


func check_all_folders(folder_path: String) -> Array:
	var folderArray:Array = []
	var dir = Directory.new()
	if dir.open(folder_path) == OK:
		dir.list_dir_begin()
		var file_path = dir.get_next()
		while file_path != "":
			if dir.current_is_dir() && (file_path != ".") && (file_path != ".."):
				folderArray.append(file_path)
			file_path = dir.get_next()
		dir.list_dir_end()
	return folderArray

func array_with_script(folder_path, array) -> Array:
	var newArray:Array = []
	for value in array:
		var dir = Directory.new()
		if dir.open(folder_path + value) == OK:
			if dir.file_exists("script.json"): 
				newArray.append(value)
	return newArray

func add_button(title, dict, folder_path, folder):
	$no_manga.visible = false
	var NewButton = TemplateButton.instance()
	NewButton.name = title
	NewButton.text = title
	NewButton.Dict = dict
	NewButton.folder = folder
	NewButton.location = folder_path + folder
	NewButton.visible = true
	add_child(NewButton)
