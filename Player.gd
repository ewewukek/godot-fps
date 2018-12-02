extends KinematicBody

var MOUSE_SENSITIVITY = 0.05

var camera
var neck

func _ready():
	neck = $Neck
	camera = $Neck/Camera

	# TODO: move somewhere else
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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

	# TODO: move somewhere else
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if input_move.length() > 0:
		input_move = input_move.normalized()
		var velocity = global_transform.basis * input_move
		move_and_slide(velocity, Vector3(0, 1, 0), 0.05, 2, deg2rad(45))

func _input(event):
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        neck.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
        rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

        var camera_rot = neck.rotation_degrees
        camera_rot.x = clamp(camera_rot.x, -70, 70)
        neck.rotation_degrees = camera_rot