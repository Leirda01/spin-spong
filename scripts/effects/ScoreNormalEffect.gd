extends Node2D

func _ready():
	for particle in [$Gradients, $Spread, $Glow, $GlowBorder]:
		particle.emitting = true
	Signals.emit_signal("screen_shake",0.1,5)


func setup_color_ramps(color):
	for particle in [$Gradients, $Spread, $Glow, $GlowBorder]:
		particle.color_ramp = Effect.create_alpha_gradient(color, 0.6, 0)


func _on_ParticlesDeletion_timeout():
	queue_free()
