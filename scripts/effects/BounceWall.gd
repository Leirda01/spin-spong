extends Node2D


var color_ramp setget setup_color_ramps


func _ready():
	for particle in [$SquareLine, $SquareFlash, $Glow]:
		particle.emitting = true


func setup_color_ramps(color: Color):
	$SquareLine.color_ramp = Effect.create_alpha_gradient(color, 0.7, 0)
	$SquareFlash.self_modulate = color
	$Glow.color_ramp = Effect.create_alpha_gradient(color, 0.3, 0)


func _on_ParticlesDeletion_timeout():
	queue_free()


func _on_JuiceTrigger_timeout():
	Effect.emit_signal("screen_shake", 0.1, 1)
	Effect.screen_freeze(20)
