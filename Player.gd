extends KinematicBody

const WALK_SPEED = 1.6
const WALK_ACCELERATION = WALK_SPEED * 9.0
const WALK_DECELERATION = WALK_SPEED * 9.0
const RUN_SPEED = 3.7
const SPRINT_SPEED = 6.5

var velocity

var MOUSE_SENSITIVITY = deg2rad(0.12)
var CAMERA_PITCH_LIMIT = deg2rad(90.0)

var camera
var neck

func _ready():
	velocity = Vector3(0.0, 0.0, 0.0)
	neck = $Neck
	camera = $Neck/Camera

func _physics_process(delta):
	var direction = Vector3()

	if Input.is_action_pressed("move_forward"):
		direction.z -= 1.0
	if Input.is_action_pressed("move_backward"):
		direction.z += 1.0
	if Input.is_action_pressed("move_left"):
		direction.x -= 1.0
	if Input.is_action_pressed("move_right"):
		direction.x += 1.0

	var acceleration = delta * WALK_ACCELERATION
	var deceleration = delta * WALK_DECELERATION
	var max_velocity = WALK_SPEED

	if direction.x != 0 or direction.z != 0:
		direction = global_transform.basis * direction.normalized()
		velocity += acceleration * direction
		var speed = Vector2(velocity.x, velocity.z).length()
		if speed > max_velocity:
			velocity = (max_velocity / speed) * velocity
	else:
		var speed = Vector2(velocity.x, velocity.z).length()
		if speed > deceleration:
			velocity -= (deceleration / speed) * velocity
		else:
			velocity.x = 0
			velocity.z = 0

	move_and_slide(velocity, Vector3(0, 1, 0), 0.05, 4, deg2rad(45))

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		neck.rotation.x = clamp(neck.rotation.x - MOUSE_SENSITIVITY * event.relative.y, -CAMERA_PITCH_LIMIT, CAMERA_PITCH_LIMIT)
		rotate_y(-MOUSE_SENSITIVITY * event.relative.x)
