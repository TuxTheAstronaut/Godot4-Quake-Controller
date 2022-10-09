extends Node

var sync_position : Vector3 = Vector3.ZERO

var sync_vel : Vector3 = Vector3.ZERO

@rpc(reliable)
func crouch(crouching):
	get_parent().player_scene.crouching = crouching
