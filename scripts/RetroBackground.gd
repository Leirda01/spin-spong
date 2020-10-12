extends Node2D

export var speed := 6.0
export var luminosity := 0.4
var lines_target := Vector2.ZERO
var gradient_target := Vector2.ZERO
var color_left
var color_right
onready var markers = [$ScoreMarkers/Marker1, $ScoreMarkers/Marker2,
						$ScoreMarkers/Marker3, $ScoreMarkers/Marker4,
						$ScoreMarkers/Marker5, $ScoreMarkers/Marker6,
						$ScoreMarkers/Marker7, $ScoreMarkers/Marker8,
						$ScoreMarkers/Marker9, $ScoreMarkers/Marker10,
						$ScoreMarkers/Marker11, $ScoreMarkers/Marker12,]


func setup(col_left, col_right):
	color_left = col_left
	color_right = col_right
	var gradient = Gradient.new()
	var filter = Color(luminosity,luminosity,luminosity,1)
	gradient.add_point(0, color_left * filter)
	gradient.add_point(.9999, color_right * filter)
	$Gradient.texture.set_gradient(gradient)
	$Gradient.texture.set_width(get_tree().root.size.x * 2 + 6)


func _process(delta):
	$Gradient.position = \
		$Gradient.position.linear_interpolate(gradient_target, delta * speed)
	$Lines.position = \
		$Lines.position.linear_interpolate(lines_target, delta * speed)


func set_background(coeff: float):
	lines_target = Vector2(-coeff * 192, 0) #multiples of 96
	gradient_target = Vector2(coeff * get_tree().root.size.x / 2, 0)


func update_markers(score : int, direction : int):
	for i in range(markers.size()):
		
		var color
		var flash = false
		
		if i < score*2 :
			color = color_left
			if direction == 1 : flash = true
		else :
			color = color_right
			if direction == -1 : flash = true
			
		markers[i].material.set_shader_param("targ_color", color)
		if flash : markers[i].get_node("FlashPlayer").play("Flash")
