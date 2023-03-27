extends GridContainer

func _on_c_bind_col_toggled(button_pressed):
	if(button_pressed):
		$cp_panel.disabled = true
		$b_ran_panel.disabled = true
	else:
		$cp_panel.disabled = false
		$b_ran_panel.disabled = false


func _on_b_ran_main_pressed():
	$cp_main.color = Color(randf()*0.6,randf()*0.6,randf()*0.6, 1)


func _on_b_ran_panel_pressed():
	$cp_panel.color = Color(randf(),randf(),randf(), 1)


func _on_b_ran_bg_pressed():
	$cp_bg.color = Color(randf(),randf(),randf(), 1)
