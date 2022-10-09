extends CharacterBody3D

var crouching : bool:
	set(value):
		crouch(value)

@onready var pcap = $CollisionShape3D

func _physics_process(delta):
	move_and_slide()

func crouch(C):
	if C:
		pcap.shape.height = 1.5
		pcap.position.y = -0.25
		$MeshInstance3d.mesh.height = 1.5
		$MeshInstance3d.position.y = -0.25
	else:
		pcap.shape.height = 2
		pcap.position.y = 0.0
		$MeshInstance3d.mesh.height = 2
		$MeshInstance3d.position.y = 0.0

