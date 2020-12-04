extends Node


signal screen_shake(duration, strength)


func _ready() -> void:
	randomize()


static func screen_freeze(duration: int) -> void:
	OS.delay_msec(duration)


static func create_alpha_gradient(color := Color.cyan, start_alpha := 0.0, end_alpha := 1.0) -> Gradient:
	var gradient := Gradient.new()
	gradient.add_point(0, color * Color(1, 1, 1, start_alpha))
	gradient.add_point(.9999, color * Color(1, 1, 1, end_alpha))
	return gradient


static func create_effect(e: Dictionary) -> Node:
	var instance = e["scene"].instance()
	instance.color_ramp = e["color_ramp"] if e.has("color_ramp") else Effect.create_alpha_gradient()
	instance.rotation_degrees = e["rotation"] if e.has("rotation") else 0
	instance.position = e["position"] if e.has("position") else Vector2.ZERO
	return instance
