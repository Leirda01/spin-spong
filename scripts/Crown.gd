extends AnimatedSprite


func _ready():
	frame = 0
	play("fade-in")


func fade_out():
	if animation == "wait":
		play("fade-out")
		$Particles.emitting = false
		return true
	return false


func set_color(color):
	material.set_shader_param("targ_color", color)
	$Particles.color_ramp = Effect.create_alpha_gradient(color, 0.4, 0)


func _on_Crown_animation_finished():
	match animation:
		"fade-in":
			play("wait")
			$Particles.emitting = true
		"fade-out":
			$ParticlesDeletion.start()


func _on_ParticlesDeletion_timeout():
	queue_free()
