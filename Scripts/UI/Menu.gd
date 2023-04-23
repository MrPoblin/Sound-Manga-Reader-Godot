extends Control

onready var SettingsNode = load("res://Scenes/UI/Settings.tscn")
onready var latestSave:Array = State.state.get_value("save", "latest", [])


func _on_settings_button_pressed():
	if($Panel.has_node("Settings")):
		$Panel/Settings.toggle_visibility()

func _on_controls_button_pressed():
	$Popup.popup()

var isRunning = false
func _on_Menu_resized():
	if(!isRunning):
		isRunning = true
		$CreditsPopup/Credits/CreditsContainer.hide_popup()
		var popup_nodes = get_tree().get_nodes_in_group("popup")
		for i in popup_nodes:
			i.visible = false
		yield(get_tree().create_timer(0.4), "timeout")
		isRunning = false

#func _input(event):
#	if event is InputEventKey:
#		if event.is_action_pressed("help"):
#			$Popup.popup()

func _on_resume_button_pressed():
	latestSave = State.state.get_value("save", "latest")
	State.Core = State.load_script(Config.config.get_value("storage", "manga") + latestSave[0] + "/script.json")
	if(State.Core): 
		State.FolderLocation = Config.config.get_value("storage", "manga") + latestSave[0]
		State.Folder = latestSave[0]
		var root_node = get_tree().get_root()
		root_node.get_node("Main").init_reader(latestSave[1], latestSave[2])
	else: $ErrorCore.popup_centered()

func _on_resume_button_mouse_entered():
	latestSave = State.state.get_value("save", "latest", [])
	$MainMenuButtons/resume_button.hint_tooltip = "'" + String(latestSave[0]) + "' - Chapter " + String(latestSave[1]) + " - Page " + String(latestSave[2])

func _on_Menu_visibility_changed():
	latestSave = State.state.get_value("save", "latest", [])
	if(latestSave):
		$MainMenuButtons/resume_button.visible = true
	else:
		$MainMenuButtons/resume_button.visible = false

func _on_resume_button_gui_input(event):
	if (event is InputEventMouseButton && event.button_index == BUTTON_MIDDLE && !event.is_pressed()):
		$MainMenuButtons/resume_button.visible = false
		State.clearState()

func _on_credits_button_pressed():
	$CreditsPopup.popup()
