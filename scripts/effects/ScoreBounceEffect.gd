extends Node2D

func _ready():
	for particle in [$Glow, $Spread]:
		particle.emitting = true


func setup_color_ramps(color):
	for particle in [$Glow, $Spread]:
		particle.color_ramp = Effect.create_alpha_gradient(color, 0.4, 0)


func _on_ParticlesDeletion_timeout():
	queue_free()
