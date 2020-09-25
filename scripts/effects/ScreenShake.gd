extends Node2D

var shaking_active:= false
var shake_force: int

func _ready():
	Signals.connect("screen_shake", self, "on_screen_shake")

func on_screen_shake(duration: float, force: int):
	shaking_active = true
	shake_force = force
	$Duration.start(duration)


func _process(_delta):
	if shaking_active:
		owner.offset = Vector2( round(rand_range(- shake_force, shake_force)),
								round(rand_range(- shake_force, shake_force)))


func _on_Duration_timeout():
	shaking_active = false
	owner.offset = Vector2(0, 0)
