extends KinematicBody

var vel = Vector3()
const MAX_SPEED = 10

var dir = Vector3()

const MAX_SLOPE_ANGLE = 40

var lookTarget = "../Ballon";
#var lookPos

func _ready():
	set_process(true)

func _physics_process(delta):
    process_movement(delta)

func process_movement(delta):
	
	#lookPos = get_node(lookTarget).get_transform().origin
	#look_at(lookPos,Vector3(0,1,0))
	
	var cible = (get_node(lookTarget).get_transform().origin - get_transform().origin).normalized()

	dir.y = 0
	dir = cible.normalized()
	var target = dir
	target *= MAX_SPEED

	vel = vel.linear_interpolate(target, delta)
	vel = Vector3(vel.x, 0, 0)
	vel = move_and_slide(vel,Vector3(0,1,0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))

func _on_Area_body_entered(body):
	if body.is_in_group("Ballon"):
		body.apply_impulse(Vector3(0, 0, 0),Vector3(0,10,-50))
