extends Control

var position_label
var player

func _ready():
	position_label = $Label
	player = get_node("/root/Root/Player")

func _process(delta):
	var position = player.global_transform.origin
	position_label.text = "%.2f %.2f %.2f" % [position.x, position.y, position.z]
