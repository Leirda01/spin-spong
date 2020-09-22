extends Node2D

func _ready():
	$Glow.emitting = true
	$Spread.emitting = true


func setup_color_ramps(color):
	var color_ramp = Effect.create_alpha_gradient(color, 0.4, 0)
	$Spread.color_ramp = color_ramp
	$Glow.color_ramp = color_ramp

func _on_ParticlesDeletion_timeout():
	queue_free()
