extends AnimatedSprite

var formed := false

func _ready():
	fade_in()

func fade_in():
	play ("Fade-in")

func fade_out():
	play ("Fade-out")

func set_color(color):
	material.set_shader_param("targ_color", color)

func _on_Crown_animation_finished():
	if animation == "Fade-in":
		formed = true
	else:
		queue_free()
