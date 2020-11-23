extends RigidBody2D

const bounce_wall_effect = preload("res://scenes/effects/BounceWallEffect.tscn")

export var base_speed: int
export var max_speed: int
export(Color) var color

var speed
const SMASH = 6.0

func _ready():
	speed = base_speed
	material.set_shader_param("targ_color", color)

	linear_velocity = Vector2.LEFT
	self.stop()


func _integrate_forces(state):
	if linear_velocity.length() < base_speed:
		linear_velocity = linear_velocity.normalized() * base_speed
	else: linear_velocity = linear_velocity.clamped(speed)

	if state.get_contact_count() > 0:
		var effect := {}
		if state.get_contact_collider_object(0).is_in_group("BorderWalls"):
			effect = {
				"scene": bounce_wall_effect,
				"rotation": rad2deg(state.get_contact_local_normal(0).angle()),
				"color_ramp": color,
				"position": state.get_contact_local_position(0),
			}
		spawn_bounce_effect(effect)


func _on_paddle_bounce(paddle):
	if paddle.name != "Paddle":
		return

	# Set ball speed depending on paddle rotation speed
	speed = max_speed if abs(paddle.angular_velocity) >= SMASH else base_speed

	# Stop the ball from being stuck almost vertically
	if linear_velocity.normalized().dot(Vector2.UP) > 0.8:
		linear_velocity = Vector2.UP
	if linear_velocity.normalized().dot(Vector2.DOWN) > 0.8:
		linear_velocity = Vector2.DOWN


func launch():
	linear_velocity += Vector2.ZERO


func stop():
	set_sleeping(true)


func increase_speed():
	if speed < max_speed:
		speed += base_speed


func spawn_bounce_effect(effect):
	if effect.empty(): return
	var bounce_effect_instance = effect["scene"].instance()
	bounce_effect_instance.setup_color_ramps(effect["color_ramp"])
	bounce_effect_instance.rotation_degrees = effect["rotation"]
	bounce_effect_instance.position = effect["position"]
	owner.add_child(bounce_effect_instance)
