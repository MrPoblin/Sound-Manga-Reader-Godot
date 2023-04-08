extends Button

func _on_ChapterButtonTemplate_pressed():
	var root_node = get_tree().get_root()
	root_node.get_node("Main").init_reader(self.name, 0)
