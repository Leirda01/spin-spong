extends Node

func create_gradient_to_alpha(color, start_alpha, end_alpha):
	var gradient = Gradient.new()
	gradient.add_point(0,color*Color(1,1,1,start_alpha))
	gradient.add_point(.999,color*Color(1,1,1,end_alpha))
	return gradient
