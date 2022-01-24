extends KinematicBody

onready var lookTarget = "../Joueur 1"
onready var Jai = $"AudioStreamPlayer3D-1"

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	process_movement(delta)
	
func process_movement(delta):
	var lookPos = get_node(lookTarget).get_transform().origin
	look_at(lookPos, Vector3(0,1,0))

func _on_body_entered(body:Node):
	print("AIBallon")
	Jai.play(0)
	if body.is_in_group("Ballon"):
		var forcemult=5
		var direction = get_node(lookTarget).get_transform().origin
		var global_direction = get_transform().basis.xform(direction).normalized()
		body.apply_impulse(Vector3(0,0,0), direction * forcemult)
