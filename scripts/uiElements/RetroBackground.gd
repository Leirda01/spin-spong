extends Node2D


export var speed := 6.0
export var luminosity := 0.4


var target_line := Vector2.ZERO
var target_gradient := Vector2.ZERO
var color_left: Color
var color_right: Color


func setup(left: Color, right: Color):
	color_left = left
	color_right = right
	var gradient = Gradient.new()
	var filter = Color(luminosity, luminosity, luminosity, 1)
	gradient.add_point(0, color_left * filter)
	gradient.add_point(.9999, color_right * filter)
	$Gradient.texture.set_gradient(gradient)
	$Gradient.texture.set_width(get_tree().root.size.x * 2 + 6)


func _process(delta):
	$Gradient.position = \
		$Gradient.position.linear_interpolate(target_gradient, delta * speed)
	$Lines.position = \
		$Lines.position.linear_interpolate(target_line, delta * speed)


func set_background(coeff: float):
	target_gradient = Vector2(coeff * get_tree().root.size.x / 2, 0)
	target_line = Vector2(coeff * 192, 0) # multiples of 96


func update_markers(score: int, dir: int):
	# warning-ignore:incompatible_ternary
	var right_strikes = true if dir == -1 else false if dir == 1 else null

	for marker in $ScoreMarkers.get_children():
		var is_on_left_side: bool = marker.name.to_int() <= score * 2

		marker.material.set_shader_param(
			"targ_color",
			color_left if is_on_left_side else color_right
		)

		if right_strikes != null and int(is_on_left_side) ^ int(right_strikes):
				marker.get_node("FlashPlayer").play("flash")
