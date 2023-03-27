extends Button


func _on_SettingDiscard_pressed():
	$DiscardConf.popup_centered_minsize(Vector2(100, 50))


func _on_DiscardConf_confirmed():
	get_tree().reload_current_scene()
