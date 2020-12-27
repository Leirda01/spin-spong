extends Node2D


var color_ramp setget setup_color_ramps


func _ready():
	for particle in [$Rhombuses, $Scatter, $Flash, $FlashLine, $Ripple]:
		particle.emitting = true


func setup_color_ramps(color: Color):
	$Rhombuses.color_ramp = Effect.create_alpha_gradient(color, 1, 0.1)
	$Scatter.color_ramp = Effect.create_alpha_gradient(color, 0.8, 0.6)
	$Flash.color_ramp = Effect.create_alpha_gradient(color.inverted(), 1, 0)
	$FlashLine.color_ramp = Effect.create_alpha_gradient(color.inverted(), 0.6, 0.05)
	$Ripple.color_ramp = Effect.create_alpha_gradient(color, 0.8, 0)

func _on_ParticlesDeletion_timeout():
	queue_free()


func _on_JuiceTrigger_timeout():
	Effect.emit_signal("screen_shake", 0.3, 20) #0.5 12
	Effect.screen_freeze(105)#85
