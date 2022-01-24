extends KinematicBody

var vel = Vector3()
const MAX_SPEED = 10

var dir = Vector3()

const MAX_SLOPE_ANGLE = 40

var lookTarget = "../Ballon";
var lookCage = "../Terrain de CeciFoot/Enbut2";
var lookPos

func _ready():
	set_process(true)

func _physics_process(delta):
	process_movement(delta)

func process_movement(delta):
	
	lookPos = get_node(lookTarget).get_transform().origin
	lookPos.y = 0
	look_at(lookPos,Vector3(0,1,0))
	
#	var cible = (lookPos - get_transform().origin).normalized()

	var cible = (lookPos - get_node(lookCage).get_transform().origin)
	var target = (cible - get_transform().origin)
	
	vel = vel.linear_interpolate(target, delta)

	if get_transform().origin.x > 14.7:
		vel.x = -0.5
	if get_transform().origin.x < -12.9:
		vel.x = 0.5
	if get_transform().origin.z < -39.2:
		vel.z = 2
	if get_transform().origin.z > -28.3:
		vel.z = -0.5
	vel.y = 0
	var global_vel = global_transform.basis.xform(vel).normalized()
	global_vel.y = 0
	global_vel *= MAX_SPEED

	global_vel = move_and_slide(-global_vel,Vector3(0,1,0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))

func _on_body_entered(body:Node):
	if body.is_in_group("Ballon"):
		body.apply_impulse(Vector3(0, 0, 0),Vector3(0,10,50))
