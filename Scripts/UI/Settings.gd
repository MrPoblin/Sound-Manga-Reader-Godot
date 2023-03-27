extends Control


func toggle_visibility():
	visible = not visible

func _ready():
	visible = false


func _on_manga_button_pressed():
	visible = false
