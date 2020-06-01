extends AnimatedSprite


func _ready():
	frame = 0
	play("Fade-in")


func fade_out():
	if animation == "Outline":
		play("Fade-out")
		$Particles.emitting = false
		return true
	return false


func set_color(color):
	material.set_shader_param("targ_color", color)
	$Particles.color_ramp = \
	Effect.create_alpha_gradient(color, 0.4, 0)


func _on_Crown_animation_finished():
	match animation:
		"Fade-in":
			play ("Outline")
			$Particles.emitting = true
		"Fade-out":
			$ParticlesDeletion.start()
			playing = false
			frame = get_sprite_frames().get_frame_count("Fade-out") - 1


func _on_ParticlesDeletion_timeout():
	queue_free()
