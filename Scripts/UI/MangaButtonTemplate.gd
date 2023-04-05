extends Button

var Dict:Dictionary
var location:String


func _on_TemplateButton_pressed():
	State.Core = Dict
	State.FolderLocation = location
	var root_node = get_tree().get_root()
	var ChapterNode = root_node.get_node("Main/Menu/MangaList/ChapterSelect")
	ChapterNode.visible = true
