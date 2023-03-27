extends ColorRect

func _ready():
	color = Config.config.get_value("color", "panel", Color.black.lightened(0.12))
	pass





