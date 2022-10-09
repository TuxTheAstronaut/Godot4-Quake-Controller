extends Node

var player_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Network.set_multiplayer_authority(str(name).to_int())
	$Network/PhysicsSynchronizer.set_multiplayer_authority(str(name).to_int())
	if str(multiplayer.get_unique_id()) == self.name:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		var local_player = load("res://Scenes/Player.tscn").instantiate()
		add_child(local_player)
		player_scene = local_player
		get_node("Player").crouch.connect(self.Player_crouch)
	else :
		var puppet_player = load("res://Scenes/player_puppet.tscn").instantiate()
		add_child(puppet_player)
		player_scene = puppet_player

func _physics_process(delta):
	if !is_local_authority():
		if player_scene.global_transform.origin != $Network.sync_position:
			player_scene.global_transform.origin = $Network.sync_position
		player_scene.velocity = $Network.sync_vel
	else:
		$Network.sync_position = player_scene.global_transform.origin
		$Network.sync_vel = player_scene.velocity

func Player_crouch(crouching):
	$Network.rpc("crouch", crouching)

func is_local_authority():
	return $Network/PhysicsSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id()
