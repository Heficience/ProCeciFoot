extends KinematicBody

const GRAVITY = -24.8
var vel = Vector3()

const ACCEL= 4.5

var dir = Vector3()

const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40

const ray_length = 10000

var camera
var rotation_helper

var MAX_SPEED = 15
var MOUSE_SENSITIVITY = .5

var tir = false

onready var SoundBallon = get_node("/root/Spatial/Ballon/AudioStreamPlayer3D")

func _ready():
	
	camera = $RotationHelper/Camera
	rotation_helper = $RotationHelper
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
    process_input()
    process_movement(delta)

func process_input():

    # ----------------------------------
    # Walking
	dir = Vector3()
	var cam_xform = camera.get_global_transform()

	var input_movement_vector = Vector2()

	if Input.is_action_pressed("Avancer"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("Reculer"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("Aller a gauche"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("Aller a droite"):
		input_movement_vector.x = 1
	if Input.is_action_pressed("Espace"):
		tir = true
		print("tir is true")
	else:
		tir = false

	input_movement_vector = input_movement_vector.normalized()

	dir += -cam_xform.basis.z.normalized() * input_movement_vector.y
	dir += cam_xform.basis.x.normalized() * input_movement_vector.x

func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta*GRAVITY

	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel*delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel,Vector3(0,1,0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))



func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:

		var rotat = deg2rad(event.relative.x * MOUSE_SENSITIVITY  * -1)
		rotate(Vector3 (0,1,0), rotat)

		var camRotat = deg2rad(event.relative.y * MOUSE_SENSITIVITY)
		rotation_helper.rotate(Vector3 (1,0,0), camRotat)


func _on_Area_body_entered(body):
	print("JoueurBallon")
	if body.is_in_group("Ballon"):
		print("Ballon")
		SoundBallon.play(0)
		if tir:
			print("TireJoueur1")
			var forcemult=25
			var lookTarget = "../Ballon";
			var direction = get_node(lookTarget).get_transform().origin.normalized()
			var global_direction = global_transform.basis.xform(direction)
			body.apply_impulse(Vector3(0,0,0), global_direction * forcemult)