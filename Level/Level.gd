extends Node3D


func _ready():
	multiplayer.peer_connected.connect(self.spawn_player)
	multiplayer.peer_disconnected.connect(self.destroy_player)
	Main.spawn_host.connect(self.spawn_player)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			if $Panel.visible == false and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
				$Panel.show()
			elif Main.ingame:
				$Panel.hide()
			

func spawn_player(id):
	print(id)
	var player = load("res://Scenes/player_controller.tscn").instantiate()
	player.name = str(id)
	self.add_child(player)

func destroy_player(id):
	self.get_node(str(id)).queue_free()


func _on_play_pressed():
	$Window.show()
	$Window.position = Vector2(100,100)


func _on_quit_pressed():
	get_tree().quit()


func _on_fullscreen_pressed():
	Main.fullscreen()
