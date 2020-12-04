# original code by CowThing: https://github.com/godotengine/godot/issues/6506
# port to Godot 3 and bugfixes by atomius.
extends Node


onready var root = get_tree().root
onready var base_size = root.get_visible_rect().size


func _ready():
	get_tree().connect("screen_resized", self, "_on_screen_resized")
	
	root.set_attach_to_screen_rect(root.get_visible_rect())
	_on_screen_resized()


func _on_screen_resized():
	var screen_size = OS.window_size

	var ratio = screen_size / base_size
	var factor = max(1, min(floor(ratio.x), floor(ratio.y)))
	var new_size = base_size * factor
	var offset = (screen_size - new_size) / 2

	root.set_attach_to_screen_rect(Rect2(offset, new_size))

	# prevent negative values as they make the bars go in the wrong direction.
	var bars_size = Vector2(max(offset.x, 0), max(offset.y, 0))

	# Black bars to prevent flickering:
	VisualServer.black_bars_set_margins(bars_size.x, bars_size.y,
		bars_size.x + int(screen_size.x) % 2, # Don't miss a pixel!
		bars_size.y + int(screen_size.y) % 2
	)
