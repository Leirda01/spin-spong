extends Node2D

func _ready():
	$Gradients.emitting = true
	$Glow.emitting = true
	$Line.emitting = true
	$Spread.emitting = true

func setup_color_ramps(color):
	var color_ramp1 = Effect.create_alpha_gradient(color, 0.7, 0)
	var color_ramp2 = Effect.create_alpha_gradient(color, 0.8, 0.4)
	$Gradients.color_ramp = color_ramp1
	$Line.color_ramp = color_ramp2
	$Spread.color_ramp = color_ramp1
	$Glow.color_ramp = color_ramp1

func _on_ParticlesDeletion_timeout():
	queue_free()
