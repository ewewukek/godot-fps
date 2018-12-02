extends KinematicBody

var MOUSE_SENSITIVITY = deg2rad(0.12)
var CAMERA_PITCH_LIMIT = deg2rad(90)

var camera
var neck

func _ready():
	neck = $Neck
	camera = $Neck/Camera

func _physics_process(delta):
	var input_move = Vector3()

	if Input.is_action_pressed("move_forward"):
		input_move.z -= 1.0
	if Input.is_action_pressed("move_backward"):
		input_move.z += 1.0
	if Input.is_action_pressed("move_left"):
		input_move.x -= 1.0
	if Input.is_action_pressed("move_right"):
		input_move.x += 1.0

	if input_move.length() > 0:
		input_move = input_move.normalized()
		var velocity = global_transform.basis * input_move
		move_and_slide(velocity, Vector3(0, 1, 0), 0.05, 2, deg2rad(45))

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		neck.rotation.x = clamp(neck.rotation.x - MOUSE_SENSITIVITY * event.relative.y, -CAMERA_PITCH_LIMIT, CAMERA_PITCH_LIMIT)
		rotate_y(-MOUSE_SENSITIVITY * event.relative.x)
