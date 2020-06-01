class_name Ball
extends RigidBody2D

export var min_speed: int
export var max_speed: int
export(Color) var color

func _ready():
	material.set_shader_param("targ_color", color)

	linear_velocity = Vector2.LEFT
	self.stop()


func _integrate_forces(_state):
	if linear_velocity.normalized().dot(Vector2.UP) > 0.8:
		linear_velocity = Vector2.UP * min_speed
	if linear_velocity.normalized().dot(Vector2.DOWN) > 0.8:
		linear_velocity = Vector2.DOWN * min_speed

	linear_velocity = linear_velocity.clamped(max_speed)
	if linear_velocity.length() < min_speed:
		linear_velocity = linear_velocity.normalized() * min_speed


func launch():
	linear_velocity += Vector2.ZERO


func stop():
	set_sleeping(true)
