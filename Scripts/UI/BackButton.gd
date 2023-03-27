extends Button

func _on_BackButton_pressed():
	var parent = get_parent()
	parent.visible = false
