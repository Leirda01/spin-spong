extends RigidBody2D

const bounce_wall := preload("res://scenes/effects/BounceWall.tscn")
const bounce_paddle := preload("res://scenes/effects/BouncePaddle.tscn")

export var base_speed := 275
export var max_speed := 375
export(Color) var color


const MINDIR := 0.4 # Minimal direction between 0.0 and 1.0
var speed
var paddle_bounce_effect_cooldown := 1 * (1/60)
var paddle_bounce_effect_active := false



func _ready():
	speed = base_speed
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
			effect["color_ramp"] = color
		
		elif state.get_contact_collider_object(0).is_in_group("Paddles"):
			if !paddle_bounce_effect_active:
				var paddle_lock = state.get_contact_collider_object(0).owner
				paddle_bounce_effect_active = true
				paddle_lock.flash()
				effect["scene"] = bounce_paddle
				effect["color_ramp"] = paddle_lock.color
			$PaddleBounceEffectTimer.start(paddle_bounce_effect_cooldown)
		
		if !effect.empty() :
			effect["position"] = state.get_contact_local_position(0)
			effect["rotation"] = rad2deg(state.get_contact_local_normal(0).angle())
			owner.add_child(Effect.create_effect(effect))
			flash()


func launch():
	linear_velocity += Vector2.ZERO


func stop():
	set_sleeping(true)


func increase_speed():
	if speed < max_speed:
		speed += base_speed


func _on_PaddleBounceEffectTimer_timeout():
	paddle_bounce_effect_active = false


func flash():
	$AnimationPlayer.play("flash")

