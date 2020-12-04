extends RigidBody2D

const bounce_wall := preload("res://scenes/effects/BounceWall.tscn")

export(Color) var color
export var base_speed := 275
export var max_speed := 600
export var minimal_direction := 0.4 # between 0.0 and 1.0
export var smash := 6.0

var speed: float
var direction: Vector2


func _ready():
	speed = base_speed
	direction = Vector2.LEFT
	linear_velocity = direction

	material.set_shader_param("targ_color", color)

	self.stop()


func _integrate_forces(state):
	direction = linear_velocity.normalized()
	linear_velocity = direction * speed

	if state.get_contact_count() > 0 :
		var effect := {}
		if state.get_contact_collider_object(0).is_in_group("BorderWalls"):
			effect["scene"] = bounce_wall
			effect["rotation"] = rad2deg(state.get_contact_local_normal(0).angle())
			effect["color_ramp"] = color
		if !effect.empty() :
			effect["position"] = state.get_contact_local_position(0)
			owner.add_child(Effect.create_effect(effect))


func _on_paddle_bounce(paddle):
	if paddle.name != "Paddle": return

	# Set ball maximum speed depending on paddle rotation speed
	speed = max_speed if abs(paddle.angular_velocity) >= smash else base_speed

	if abs(direction.dot(Vector2.RIGHT)) <= minimal_direction:
		linear_velocity = Vector2(0, sign(direction.y)).rotated(
			sign(direction.x) * minimal_direction * PI / 2
		)


func launch():
	linear_velocity += Vector2.ZERO


func stop():
	set_sleeping(true)


func increase_speed():
	if speed < max_speed:
		speed += base_speed
