extends Control

onready var SettingsNode = load("res://Scenes/UI/Settings.tscn")

func _on_settings_button_pressed():
	if(self.has_node("Settings")):
		$Settings.toggle_visibility()


func _on_controls_button_pressed():
	$Popup.popup()


func _on_Menu_resized():
	$Popup.visible = false

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("help"):
			$Popup.popup()
