extends Node

const score_victory_effect = preload("res://scenes/effects/ScoreVictoryEffect.tscn")
const score_normal_effect = preload("res://scenes/effects/ScoreNormalEffect.tscn")
const score_bounce_effect = preload("res://scenes/effects/ScoreBounceEffect.tscn")
const crown_effect = preload("res://scenes/effects/Crown.tscn")

const target: = 3
var score: = 0
var locked: = true

func _ready():
	if $ScoreHandlers/ScoreLuc.connect("body_entered", self, "adriel_touched"):
		printerr("unable to connect 'body_entered' from 'ScoreLuc'")

	if $ScoreHandlers/ScoreAdriel.connect("body_entered", self, "luc_touched"):
		printerr("unable to connect 'body_entered' from 'ScoreAdriel'")

	if $ScoreHandlers/ScoreLock.connect("body_entered", self, "reset_lock"):
		printerr("unable to connect 'body_entered' from 'ScoreLock'")


func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("increase") and score < target - 1:
		reset_lock($Ball)
		score(1)
	if Input.is_action_just_pressed("decrease") and -score < target - 1:
		reset_lock($Ball)
		score(-1)

	if $Ball.sleeping and Input.is_action_just_released("ui_accept"):
		if not $Crown:
			start_game()
		elif $Crown.fade_out():
			start_game()


func adriel_touched(_body):
	if _body.name == "Ball": score(-1)


func luc_touched(_body):
	if _body.name == "Ball": score(1)


func reset_lock(_body):
	if _body.name == "Ball":
		locked = false
		if abs(score) >= target:
			spawn_crown()
			score = 0
			$Ball.stop()


func score(point):
	var effect: = { "scene": score_normal_effect }
	if point < 0:
		effect["rotation_degrees"] = 0
		effect["color_ramp"] = $Paddles/PaddleAdriel.color
		effect["position"] = Vector2(0, $Ball.position.y)
	else:
		effect["rotation_degrees"] = 180
		effect["color_ramp"] = $Paddles/PaddleLuc.color
		effect["position"] = Vector2(get_tree().root.size.x, $Ball.position.y)

	if not locked:
		score += point
		locked = true
		set_display()
		if abs(score) >= target:
			effect["scene"] = score_victory_effect
	else:
		effect["scene"] = score_bounce_effect
	spawn_score_effect(effect)


func start_game():
	$Ball.launch()
	set_display()


func set_display():
	$RetroBackground.display_score(float(score) / float(target))


func spawn_crown():
	var crown_effect_instance = crown_effect.instance()
	crown_effect_instance.set_color(($Paddles/PaddleAdriel if score > 0
									else $Paddles/PaddleLuc).color)
	add_child(crown_effect_instance)


func spawn_score_effect(effect):
	var score_effect_instance = effect["scene"].instance()
	score_effect_instance.rotation_degrees = effect["rotation_degrees"]
	score_effect_instance.setup_color_ramps(effect["color_ramp"])
	score_effect_instance.position = effect["position"]
	add_child(score_effect_instance)
