extends TextureRect

onready var autoResize:bool = Config.config.get_value("controls", "auto_resize", true)
onready var zoomStep:float = Config.config.get_value("controls", "zoom_step", 1.35)
onready var useMipmap:bool = Config.config.get_value("controls", "mipmaps", false)

onready var min_scale:float = 0.1
onready var max_scale:float = 40

onready var isPanning:bool = false
onready var mouseStart:Vector2
onready var doSkip:bool = false

func _process(_delta):
	if(isPanning):
		rect_position += (get_local_mouse_position() - mouseStart) * rect_scale
		mouseStart = get_local_mouse_position()
	else: $"../Bg".mouse_default_cursor_shape = Control.CURSOR_ARROW

func _input(event):
	if event.is_action_pressed("center"):
		fill_center()
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP || event.button_index == BUTTON_WHEEL_DOWN:
			if(doSkip):
				doSkip = false
			else:
				doSkip = true
				
				var old_mouse_location:Vector2 = get_local_mouse_position()
				var new_mouse_location:Vector2
				var new_rect_scale:Vector2
				
				if event.button_index == BUTTON_WHEEL_UP:
					rect_scale*=zoomStep
					rect_scale = Vector2(clamp(rect_scale.x, min_scale, max_scale), clamp(rect_scale.y, min_scale, max_scale))
					new_rect_scale = rect_scale
					new_mouse_location = get_local_mouse_position()
					rect_scale/=zoomStep
				elif event.button_index == BUTTON_WHEEL_DOWN:
					rect_scale/=zoomStep
					rect_scale = Vector2(clamp(rect_scale.x, min_scale, max_scale), clamp(rect_scale.y, min_scale, max_scale))
					new_rect_scale = rect_scale
					new_mouse_location = get_local_mouse_position()
					rect_scale*=zoomStep
				smooth_zoom(new_rect_scale)
				var new_pos = rect_position + ((new_mouse_location - old_mouse_location) * new_rect_scale)
				smooth_move(new_pos)


func load_image(fileName, chapter):
	var path:String = State.FolderLocation + "/img/ch-" + chapter + '/' + fileName + ".jpg"
	var image = Image.new()
	image.load(path)
	var tex = ImageTexture.new()
	tex.create_from_image(image)
	tex.set_flags(Texture.FLAG_FILTER | ImageTexture.STORAGE_RAW)
	if(useMipmap):
		 tex.set_flags(tex.get_flags() | Texture.FLAG_MIPMAPS)
	self.texture = tex
	if(autoResize):fill_center()
	rect_pivot_offset = rect_size/2

func fill_center():
	rect_position = Vector2(0, 0)
	rect_scale = Vector2(1, 1)
	rect_size = get_viewport().get_size()

func smooth_zoom(end):
	var tween = get_node("Tween")
	tween.interpolate_property(self, "rect_scale", rect_scale, end, 0.1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func smooth_move(end):
	var tween = get_node("Tween")
	tween.interpolate_property(self, "rect_position", rect_position, end, 0.1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

