extends Control

onready var SettingsNode = load("res://Scenes/UI/Settings.tscn")
onready var latestSave:Array = State.state.get_value("save", "latest", [])

func _ready():
	if(latestSave):
		$MainMenuButtons/resume_button.visible = true
		$MainMenuButtons/resume_button.hint_tooltip = latestSave

func _on_settings_button_pressed():
	if($Panel.has_node("Settings")):
		$Panel/Settings.toggle_visibility()

func _on_controls_button_pressed():
	$Popup.popup()


func _on_Menu_resized():
	$Popup.visible = false

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("help"):
			$Popup.popup()

func _on_resume_button_pressed():
	State.CORE = State.load_script("ass")
