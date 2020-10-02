extends Node2D

var shaking_active:= false
var strength_low: int
var strength_high: int
var rng = RandomNumberGenerator.new()

func _ready():
	Signal.connect("screen_shake", self, "on_screen_shake")


func on_screen_shake(duration: float, strength: float):
	shaking_active = true
	strength_low = -floor(strength/2)
	strength_high = ceil(strength/2)
	$Duration.start(duration)


func _process(_delta):
	if shaking_active:
		owner.offset = Vector2(rng.randi_range(strength_low, strength_high),
								rng.randi_range(strength_low, strength_high))


func _on_Duration_timeout():
	shaking_active = false
	owner.offset = Vector2(0, 0)
