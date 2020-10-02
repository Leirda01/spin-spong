extends AnimatedSprite


func _ready():
	frame = 0
	play("fade-in")


func fade_out():
	if animation == "wait":
		play("fade-out")
		$Particles.emitting = false
		Signal.emit_signal("screen_shake",0.3,3)
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
			Signal.emit_signal("screen_shake",0.1,4)
		"fade-out":
			$ParticlesDeletion.start()


func _on_ParticlesDeletion_timeout():
	queue_free()
