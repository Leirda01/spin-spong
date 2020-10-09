extends Line2D

export(int) var trail_length


func _process(_delta):
	add_point(owner.global_position)
	if get_point_count() > trail_length :
		remove_point(0)
