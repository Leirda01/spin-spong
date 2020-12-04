extends RigidBody2D

const bounce_wall_effect = preload("res://scenes/effects/BounceWallEffect.tscn")

export var base_speed: int
export var max_speed: int
export(Color) var color

const MINDIR := 0.3 # Minimal direction between 0.0 and 1.0
var speed


func _ready():
	speed = base_speed
	material.set_shader_param("targ_color", color)
	linear_velocity = Vector2.LEFT
	self.stop()
	self.custom_integrator = true


func _integrate_forces(state):
	var direction := linear_velocity.normalized()
	if abs(direction.dot(Vector2.RIGHT)) <= MINDIR:
		linear_velocity = (Vector2.UP if direction.y < 0 else Vector2.DOWN)
	linear_velocity = linear_velocity.normalized() * speed

	if state.get_contact_count() > 0 :
		var effect: = {}
		if state.get_contact_collider_object(0).is_in_group("BorderWalls"):
			effect["scene"] = bounce_wall_effect
			effect["rotation"] = rad2deg(state.get_contact_local_normal(0).angle())
			effect["color_ramp"] = color
		if !effect.empty() :
			effect["position"] = state.get_contact_local_position(0)
			owner.add_child(Effect.create_effect(effect))


func launch():
	linear_velocity += Vector2.ZERO


func stop():
	set_sleeping(true)


func increase_speed():
	if speed < max_speed:
		speed += base_speed
