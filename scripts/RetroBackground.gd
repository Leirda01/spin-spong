extends Node2D


export var speed := 6.0
export var luminosity := 0.4


var target = {
	"line": Vector2.ZERO,
	"gradient": Vector2.ZERO,
}
var color = {
	"left": Color(),
	"right": Color(),
}


func setup(color_left, color_right):
	color["left"] = color_left
	color["right"] = color_right
	var gradient = Gradient.new()
	var filter = Color(luminosity, luminosity, luminosity, 1)
	gradient.add_point(0, color_left * filter)
	gradient.add_point(.9999, color_right * filter)
	$Gradient.texture.set_gradient(gradient)
	$Gradient.texture.set_width(get_tree().root.size.x * 2 + 6)


func _process(delta):
	$Gradient.position = \
		$Gradient.position.linear_interpolate(target["gradient"], delta * speed)
	$Lines.position = \
		$Lines.position.linear_interpolate(target["line"], delta * speed)


func set_background(coeff: float):
	target["gradient"] = Vector2(coeff * get_tree().root.size.x / 2, 0)
	target["line"] = Vector2(coeff * 192, 0) # multiples of 96


func update_markers(score: int, dir: int):
	var left_strikes = true if dir == -1 else false if dir == 1 else null

	for marker in $ScoreMarkers.get_children():
		var left_side: bool = marker.name.to_int() <= score * 2

		marker.material.set_shader_param(
			"targ_color",
			color["left" if left_side else "right"]
		)

		if left_strikes != null and int(left_side) ^ int(left_strikes):
				marker.get_node("FlashPlayer").play("Flash")
