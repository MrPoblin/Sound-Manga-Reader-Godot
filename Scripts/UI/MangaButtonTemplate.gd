extends Button

var Dict:Dictionary
var location:String
var folder:String

func _on_TemplateButton_pressed():
	State.Core = Dict
	State.FolderLocation = location
	State.Folder = folder
	var root_node = get_tree().get_root()
	var ChapterNode = root_node.get_node("Main/Menu/Panel/MangaList/ChapterSelect")
	ChapterNode.visible = true
