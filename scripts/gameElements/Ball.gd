extends RigidBody2D

const bounce_wall := preload("res://scenes/effects/BounceWall.tscn")

export var base_speed := 275
export var max_speed := 375

export(Color) var color

const MINDIR := 0.4 # Minimal direction between 0.0 and 1.0
var speed: int setget update_speed
var score_boost_speed := 0.0


func _ready():
	self.speed = base_speed
	material.set_shader_param("targ_color", color)
	linear_velocity = Vector2.LEFT
	self.stop()


func _integrate_forces(state):
	var direction := linear_velocity.normalized()
	if abs(direction.dot(Vector2.RIGHT)) <= MINDIR:
		linear_velocity = Vector2(0, sign(direction.y)).rotated(
			sign(direction.x) * MINDIR * PI / 2)
	linear_velocity = linear_velocity.normalized() * speed

	if state.get_contact_count() > 0 :
		var effect := {}
		if state.get_contact_collider_object(0).is_in_group("BorderWalls"):
			effect["scene"] = bounce_wall
			effect["rotation"] = rad2deg(state.get_contact_local_normal(0).angle())
			effect["color_ramp"] = color
		if !effect.empty() :
			effect["position"] = state.get_contact_local_position(0)
			owner.add_child(Effect.create_effect(effect))


func launch():
	linear_velocity += Vector2.ZERO


func stop():
	set_sleeping(true)


func update_score_speed(multiplier: float):
	score_boost_speed = multiplier


func update_speed(s: int):
	speed = base_speed + (s * score_boost_speed)
