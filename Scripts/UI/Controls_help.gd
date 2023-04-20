extends TabContainer

func _ready():
	if(Config.config.get_value("controls", "swapLR", false)):
		$"Keyboard Controls/kb_grid/next_page".text += ", 'left', 'a'"
		$"Keyboard Controls/kb_grid/prev_page".text += ", 'right', 'd'"
		$"Mouse Controls/mouse_grid/LMB_next".text += "left click on the LEFT half of the screen"
		$"Mouse Controls/mouse_grid/LMB_prev".text += "left click on the RIGHT half of the screen"
		$"Mouse Controls/mouse_grid/BMB_next".text += "'LEFT mouse button'"
		$"Mouse Controls/mouse_grid/BMB_prev".text += "'RIGHT mouse button'"
	else:
		$"Keyboard Controls/kb_grid/next_page".text += ", 'right', 'd'"
		$"Keyboard Controls/kb_grid/prev_page".text += ", 'left', 'a'"
		$"Mouse Controls/mouse_grid/LMB_next".text += "left click on the RIGHT half of the screen"
		$"Mouse Controls/mouse_grid/LMB_prev".text += "left click on the LEFT half of the screen"
		$"Mouse Controls/mouse_grid/BMB_next".text += "'RIGHT mouse button'"
		$"Mouse Controls/mouse_grid/BMB_prev".text += "'LEFT mouse button'"
