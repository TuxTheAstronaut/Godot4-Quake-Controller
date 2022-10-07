extends Node

var player_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Network/PhysicsSynchronizer.set_multiplayer_authority(str(name).to_int())
	if str(multiplayer.get_unique_id()) == self.name:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		var local_player = load("res://Scenes/Player.tscn").instantiate()
		add_child(local_player)
		player_scene = local_player
	else :
		var puppet_player = load("res://Scenes/player_puppet.tscn").instantiate()
		add_child(puppet_player)
		player_scene = puppet_player

func _physics_process(delta):
	if !is_local_authority():
		player_scene.global_transform.origin = lerp($Network.sync_position, player_scene.global_transform.origin, 20*delta)
		player_scene.velocity = $Network.sync_vel
		player_scene.move_and_slide()
	else:
		$Network.sync_position = player_scene.global_transform.origin
		$Network.sync_vel = player_scene.velocity

func is_local_authority():
	return $Network/PhysicsSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id()
