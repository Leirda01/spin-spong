extends Node2D

export var speed := 6.0
var target := Vector2.ZERO


func _process(delta):
	$Background.position = \
		$Background.position.linear_interpolate(target, delta * speed)
	$Gradient.position = - $Background.position


func display_score(coeff: float):
	target = - Vector2(coeff * get_tree().root.size.x / 2, 0)
