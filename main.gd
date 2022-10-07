extends Node

var ingame = false
var peer = ENetMultiplayerPeer.new()

const PORT = 4242
var ADDRESS = "127.0.0.1"

signal spawn_host

func _ready():
	print("press ESCAPE to show mouse")
	print("press F11 to fullscreen")
	DisplayServer.window_set_min_size(Vector2i(1152,648))

# pauses game when user hits escape
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE and ingame:
			match Input.get_mouse_mode():
				Input.MOUSE_MODE_VISIBLE:
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				Input.MOUSE_MODE_CAPTURED:
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if event.keycode == KEY_F11:
			fullscreen()

func fullscreen():
	if DisplayServer.window_get_mode() != 3:
		DisplayServer.window_set_mode(3)
	else:
		DisplayServer.window_set_mode(0)
		DisplayServer.window_set_flag(1, false)

func host_server():
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	emit_signal("spawn_host", 1)

func join_server():
	peer.create_client(ADDRESS,PORT)
	multiplayer.multiplayer_peer = peer
