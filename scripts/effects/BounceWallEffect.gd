extends Node2D

func _ready():
	for particle in [$SquareLine, $SquareFlash, $Glow]:
		particle.emitting = true


func setup_color_ramps(color):
	$SquareLine.color_ramp = Effect.create_alpha_gradient(color, 0.7, 0)
	$SquareFlash.self_modulate = color
	$Glow.color_ramp = Effect.create_alpha_gradient(color, 0.3, 0)


func _on_ParticlesDeletion_timeout():
	queue_free()


func _on_JuiceTrigger_timeout():
	Signal.emit_signal("screen_shake",0.1,1)
	Effect.screen_freeze(20)#20
