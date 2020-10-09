extends RigidBody2D

export var base_speed: int
export var max_speed: int
export(Color) var color

var speed


func _ready():
	speed = base_speed
	material.set_shader_param("targ_color", color)

	linear_velocity = Vector2.LEFT
	self.stop()


func _integrate_forces(state):
	if linear_velocity.normalized().dot(Vector2.UP) > 0.8:
		linear_velocity = Vector2.UP
	if linear_velocity.normalized().dot(Vector2.DOWN) > 0.8:
		linear_velocity = Vector2.DOWN
	linear_velocity = linear_velocity.normalized() * speed
#	if state.get_contact_count() > 0 :
#		print(" ")
#		print(state.get_contact_local_normal(0))
#		print(state.get_contact_collider_object(0).name)


func launch():
	linear_velocity += Vector2.ZERO


func stop():
	set_sleeping(true)


func increase_speed():
	if speed < max_speed:
		speed += base_speed
