extends Button


func _on_SettingReset_pressed():
	$ResetConf.popup_centered_minsize(Vector2(100, 50))


func _on_ResetConf_confirmed():
	Config.initConfig()
	get_tree().reload_current_scene()
