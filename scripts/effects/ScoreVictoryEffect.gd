extends Node2D

func _ready():
	for particle in [$Rhombuses, $Scatter, $Flash, $Glow]:
		particle.emitting = true


func setup_color_ramps(color):
	$Rhombuses.color_ramp = Effect.create_alpha_gradient(color, 1, 0)
	$Scatter.color_ramp = Effect.create_alpha_gradient(color, 0.8, 0)
	$Flash.color_ramp = Effect.create_alpha_gradient(color.inverted(), 1, 0)
	$Glow.color_ramp = Effect.create_alpha_gradient(color, 0.8, 0)

func _on_ParticlesDeletion_timeout():
	queue_free()
	

func _on_JuiceTrigger_timeout():
	Signal.emit_signal("screen_shake",0.5,12)
	Effect.screen_freeze(85)
