extends Control

var player

func _ready():
	player = get_node("/root/Main/Player")

func _process(delta):
	var position = player.global_transform.origin
	$Position.text = "%.2f %.2f %.2f" % [position.x, position.y, position.z]
	$FPS.text = str(Engine.get_frames_per_second())
