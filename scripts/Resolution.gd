extends Node

onready var viewport = get_viewport()


func _ready():
	get_tree().connect("screen_resized", self, "set_resolution")
	set_resolution()


func set_resolution():
	var screen_size = OS.get_window_size()
	var width_factor = floor(screen_size.x / viewport.size.x)
	var height_factor = floor(screen_size.y / viewport.size.y)
	var factor = max(1, min(width_factor, height_factor))
	var new_size = viewport.size * factor
	var offset = (screen_size - new_size)/2
	viewport.set_attach_to_screen_rect(Rect2(offset, new_size))
