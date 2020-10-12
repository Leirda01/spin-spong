extends Node

func _ready():
	randomize()
	#Engine.time_scale = 0.5

static func create_alpha_gradient(color, start_alpha, end_alpha):
	var gradient = Gradient.new()
	gradient.add_point(0, color * Color(1, 1, 1, start_alpha))
	gradient.add_point(.9999, color * Color(1, 1, 1, end_alpha))
	return gradient
	
static func screen_freeze(duration):
	OS.delay_msec(duration)
