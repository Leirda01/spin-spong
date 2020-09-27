extends Node2D

func _ready():
	for particle in [$Gradients, $GradientsWhite, $Glow, $GlowBorder, $Line, $Spread]:
		particle.emitting = true


func setup_color_ramps(color):
	for particle in [$Gradients, $Glow, $GlowBorder, $Spread]:
		particle.color_ramp = Effect.create_alpha_gradient(color, 0.7, 0)
	$Line.color_ramp = Effect.create_alpha_gradient(color, 0.8, 0.4)


func _on_ParticlesDeletion_timeout():
	queue_free()
	

func _on_JuiceTrigger_timeout():
	Signal.emit_signal("screen_shake",0.2,10)
	Effect.screen_freeze(60)
