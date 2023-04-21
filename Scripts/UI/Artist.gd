extends Label

func _on_ChapterList_visibility_changed():
	var artName: String = State.Core["art"]
	if(artName):
		text = "Art: " + artName
	else:
		text = ""
