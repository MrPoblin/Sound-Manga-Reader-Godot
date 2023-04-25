extends HBoxContainer


func _ready():
	$op_ffmpeg.add_item ( "Disabled", 0 )
	$op_ffmpeg.add_item ( "Copy", 1 )
	$op_ffmpeg.add_item ( "Replace", 2 )
	$b_ffmpeg_convert/convert_popup.get_ok().visible = false
	

func _on_b_ffmpeg_convert_pressed():
	$b_ffmpeg_convert/convert_popup.popup_centered()
