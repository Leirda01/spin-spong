extends RigidBody2D

enum RotationStyle {NORMAL = -1, INVERTED = 1}
export(RotationStyle) var rotation_direction

export(String) var up
export(String) var down
export(Color) var color


const speed:= 2000
const rotation_speed:= 12000

onready var paddle:= $Paddle as PhysicsBody2D

func _ready():
	paddle.material.set_shader_param("targ_color", color)

func _integrate_forces(_state):
	var input = int(Input.is_action_pressed(down)) - \
				int(Input.is_action_pressed(up))

	applied_force = Vector2(0, input * speed)
	paddle.applied_torque = rotation_direction * input * rotation_speed
