extends Node2D


var color_ramp setget setup_color_ramps


func _ready():
	for particle in [$Rhombus, $Scatter, $Glow]:
		particle.emitting = true


func setup_color_ramps(color: Color):
	$Rhombus.color_ramp = Effect.create_alpha_gradient(color, 0.2, 0)
	$Scatter.color_ramp = Effect.create_alpha_gradient(color, 1, 0)
	$Glow.color_ramp = Effect.create_alpha_gradient(color, 0.5, 0)


func _on_ParticlesDeletion_timeout():
	queue_free()


func _on_JuiceTrigger_timeout():
	Effect.emit_signal("screen_shake", 0.1, 3)
	Effect.screen_freeze(40)
