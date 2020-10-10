extends Node2D

export var speed := 6.0
var target := Vector2.ZERO


func _process(delta):
	$Gradient.position = \
		$Gradient.position.linear_interpolate(target, delta * speed)


func display_score(coeff: float, frame:  int):
	target = Vector2(coeff * get_tree().root.size.x / 2, 0)
	$Marker.frame = frame
	$MarkerGlows.frame = frame
