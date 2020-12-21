extends Node2D


var color_ramp setget setup_color_ramps


func _ready():
	for particle in [$SquareFlash, $SquareScatter, $Glow]:
		particle.emitting = true


func setup_color_ramps(color: Color):
	$SquareFlash.color_ramp = Effect.create_alpha_gradient(color, 0.5, 0)
	$SquareScatter.color_ramp = Effect.create_alpha_gradient(color, 1, 0)
	$Glow.color_ramp = Effect.create_alpha_gradient(color, 0.5, 0)


func _on_ParticlesDeletion_timeout():
	queue_free()


func _on_JuiceTrigger_timeout():
	Effect.emit_signal("screen_shake", 0.05, 1)
	Effect.screen_freeze(12)
