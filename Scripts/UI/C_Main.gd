extends ColorRect

func _ready():
	color = Config.config.get_value("color", "main", Color.black)


