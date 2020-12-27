extends Node2D


var color_ramp setget setup_color_ramps


func _ready():
	for particle in [$Rhombuses, $Flash, $FlashLine, $Glow]:
		particle.emitting = true


func setup_color_ramps(color: Color):
	$Rhombuses.color_ramp = Effect.create_alpha_gradient(color, 1, 0.1)
	$Flash.color_ramp = Effect.create_alpha_gradient(color.inverted(), 1, 0)
	$FlashLine.color_ramp = Effect.create_alpha_gradient(color.inverted(), 0.6, 0.05)
	$Glow.color_ramp = Effect.create_alpha_gradient(color, 0.6, 0)

func _on_ParticlesDeletion_timeout():
	queue_free()


func _on_JuiceTrigger_timeout():
	Effect.emit_signal("screen_shake", 0.2, 12) #0.3, 9
	Effect.screen_freeze(85)#70
