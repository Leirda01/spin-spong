extends Node2D

func _ready():
	for particle in [$Rhombuses, $Flash, $FlashLine, $Glow]:
		particle.emitting = true
	


func setup_color_ramps(color):
	$Rhombuses.color_ramp = Effect.create_alpha_gradient(color, 1, 0.1)
	$Flash.color_ramp = Effect.create_alpha_gradient(color.inverted(), 1, 0)
	$FlashLine.color_ramp = Effect.create_alpha_gradient(color.inverted(), 0.6, 0.05)
	$Glow.color_ramp = Effect.create_alpha_gradient(color, 0.6, 0)

func _on_ParticlesDeletion_timeout():
	queue_free()
	

func _on_JuiceTrigger_timeout():
	Signal.emit_signal("screen_shake",0.3,9)
	Effect.screen_freeze(70)
