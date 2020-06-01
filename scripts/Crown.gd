extends AnimatedSprite

var formed := false

func _ready():
	frame = 0
	play ("Fade-in")

func fade_out():
	$Particles.emitting = false
	play ("Fade-out")

func set_color(color):
	material.set_shader_param("targ_color", color)
	$Particles.color_ramp = \
	GlobalFunctions.create_gradient_to_alpha(color,0.4,0)


func _on_Crown_animation_finished():
	match animation:
		"Fade-in":
			play ("Outline")
			$Particles.emitting = true
		"Outline":
			formed = true
		"Fade-out":
			$ParticlesDeletionTimer.start()
			playing = false
			frame = self.get_sprite_frames().get_frame_count("Fade-out")-1


func _on_ParticlesDeletionTimer_timeout():
	queue_free()
