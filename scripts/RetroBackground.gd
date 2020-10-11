extends Node2D

export var speed := 6.0
var target := Vector2.ZERO
onready var markers = [$ScoreMarkers/Marker1, $ScoreMarkers/Marker2,
						$ScoreMarkers/Marker3, $ScoreMarkers/Marker4,
						$ScoreMarkers/Marker5, $ScoreMarkers/Marker6,
						$ScoreMarkers/Marker7, $ScoreMarkers/Marker8,
						$ScoreMarkers/Marker9, $ScoreMarkers/Marker10,
						$ScoreMarkers/Marker11, $ScoreMarkers/Marker12,]


func _process(delta):
	$Gradient.position = \
		$Gradient.position.linear_interpolate(target, delta * speed)


func set_background(coeff: float):
	target = Vector2(coeff * get_tree().root.size.x / 2, 0)


func update_markers(score : int, direction : int, start_color, end_color):
	for i in range(markers.size()):
		
		var color
		var flash = false
		
		if i < score*2 :
			color = start_color
			if direction == 1 : flash = true
		else :
			color = end_color
			if direction == -1 : flash = true
			
		markers[i].material.set_shader_param("targ_color", color)
		if flash : markers[i].get_node("FlashPlayer").play("Flash")
