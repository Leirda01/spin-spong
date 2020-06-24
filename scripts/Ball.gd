class_name Ball
extends RigidBody2D

export var base_speed: int
export var max_speed: int
export(Color) var color

var speed = base_speed

func _ready():
	material.set_shader_param("targ_color", color)

	linear_velocity = Vector2.LEFT
	self.stop()


func _integrate_forces(_state):
	var direction :Vector2 = linear_velocity.normalized()

	if direction.dot(Vector2.UP) > 0.8:
		linear_velocity = Vector2.UP
	if direction.dot(Vector2.DOWN) > 0.8:
		linear_velocity = Vector2.DOWN

	linear_velocity = direction * speed


func launch():
	linear_velocity += Vector2.ZERO


func stop():
	set_sleeping(true)


func increase_speed():
	if speed < max_speed:
		speed += base_speed
