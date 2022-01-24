extends RigidBody

onready var SoundEnbut1 = get_node("/root/Spatial/Terrain de CeciFoot/Enbut1/AudioStreamPlayer")
onready var SoundEnbut2 = get_node("/root/Spatial/Terrain de CeciFoot/Enbut2/AudioStreamPlayer")

func _on_body_entered(body:Node):
	if body.is_in_group("Enbut1"):
		print("But 1")
		if not SoundEnbut1.is_playing():
			SoundEnbut1.play(0)
	if body.is_in_group("Enbut2"):
		print("But 2")
		if not SoundEnbut2.is_playing():
			SoundEnbut2.play(0)
