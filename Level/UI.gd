extends Window


func _on_window_close_requested():
	self.hide()


func _on_host_pressed():
	Main.host_server()
	self.hide()
	get_parent().get_node("Panel").hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Main.ingame = true

func _on_join_pressed():
	Main.join_server()
	self.hide()
	get_parent().get_node("Panel").hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Main.ingame = true



func _on_ip_text_submitted(new_text):
	if new_text != "":
		Main.ADDRESS = new_text
	else:
		Main.ADDRESS = "127.0.0.1"
