extends Node


const score_victory := preload("res://scenes/effects/ScoreVictory.tscn")
const score_normal := preload("res://scenes/effects/ScoreNormal.tscn")
const bounce_wall := preload("res://scenes/effects/BounceWall.tscn")
const crown := preload("res://scenes/effects/Crown.tscn")

const target: = 3
var score: = 0
var locked: = true


func _ready():
	$RetroBackground.setup($Paddles/PaddleAdriel.color, $Paddles/PaddleLuc.color)
	set_display(0)


func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("increase") and score < target - 1:
		reset_lock($Ball)
		score_add(1)
		locked = false
	if Input.is_action_just_pressed("decrease") and -score < target - 1:
		reset_lock($Ball)
		score_add(-1)
		locked = false

	if $Ball.sleeping and Input.is_action_just_released("ui_accept"):
		if not $Crown:
			start_game()
		elif $Crown.fade_out():
			start_game()


func adriel_touched(body):
	if body.name == "Ball": score_add(-1)


func luc_touched(body):
	if body.name == "Ball": score_add(1)


func reset_lock(body):
	if body.name == "Ball":
		locked = false
		if abs(score) >= target:
			add_child(Effect.create_effect({
				"scene": crown,
				"color_ramp": (
					$Paddles/PaddleAdriel if score > 0 else $Paddles/PaddleLuc
				).color
			}))
			score = 0
			$Ball.stop()


func score_add(point):
	var effect: = { "scene": score_normal }
	if point < 0:
		effect["rotation"] = 0
		effect["color_ramp"] = $Paddles/PaddleAdriel.color
		effect["position"] = Vector2(0, $Ball.position.y)
	else:
		effect["rotation"] = 180
		effect["color_ramp"] = $Paddles/PaddleLuc.color
		effect["position"] = Vector2(get_tree().root.size.x, $Ball.position.y)

	if not locked:
		score += point
		locked = true
		set_display(point)
		if abs(score) >= target:
			effect["scene"] = score_victory
	else :
		effect["scene"] = bounce_wall
		effect["color_ramp"] = $Ball.color

	add_child(Effect.create_effect(effect))


func start_game():
	$Ball.launch()
	set_display(0)


func set_display(direction : int):
	$RetroBackground.set_background(float(score) / float(target))
	$RetroBackground.update_markers (score + target, direction)
