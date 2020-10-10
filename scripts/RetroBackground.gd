extends Node2D

export var speed := 6.0
var target := Vector2.ZERO
onready var markers = [$ScoreMarkers/Markers1, $ScoreMarkers/Markers2, 
				$ScoreMarkers/Markers3, $ScoreMarkers/Markers4,
				$ScoreMarkers/Markers5, $ScoreMarkers/Markers6]


func _process(delta):
	$Gradient.position = \
		$Gradient.position.linear_interpolate(target, delta * speed)


func display_score(coeff: float, score:  int, start_color, end_color):
	target = Vector2(coeff * get_tree().root.size.x / 2, 0)
	for i in range(markers.size()):
		var col = start_color if i < score else end_color
		markers[i].material.set_shader_param("targ_color", col)
