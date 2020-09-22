extends Node

const target: = 3
var score: = 0
var locked: = true
const score_victory_effect = preload("res://scenes/effects/ScoreVictoryEffect.tscn")
const score_normal_effect = preload("res://scenes/effects/ScoreNormalEffect.tscn")
const score_bounce_effect = preload("res://scenes/effects/ScoreBounceEffect.tscn")
const crown_effect = preload("res://scenes/effects/Crown.tscn")

func _ready():
	if $ScoreHandlers/ScoreLuc.connect("body_entered", self, "adriel_touched"):
		printerr("unable to connect 'body_entered' from 'ScoreLuc'")

	if $ScoreHandlers/ScoreAdriel.connect("body_entered", self, "luc_touched"):
		printerr("unable to connect 'body_entered' from 'ScoreAdriel'")

	if $ScoreHandlers/ScoreLock.connect("body_entered", self, "reset_lock"):
		printerr("unable to connect 'body_entered' from 'ScoreLock'")


func _process(delta):
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("increase") and score < target - 1:
		reset_lock(null)
		score(1)
	if Input.is_action_just_pressed("decrease") and -score < target - 1:
		reset_lock(null)
		score(-1)

	if $Ball.sleeping and Input.is_action_just_released("ui_accept"):
		if not $Crown:
			start_game()
		elif $Crown.fade_out():
			start_game()


func adriel_touched(_body: Ball):
	score(-1)


func luc_touched(_body: Ball):
	score(1)


func reset_lock(_body: Ball):
	locked = false
	if abs(score) >= target:
		spawn_crown()
		score = 0
		$Ball.stop()


func score(point):
	var effect_x = get_tree().root.size.x
	var effect_dir = 180
	var effect_col = $Paddles/PaddleLuc.color
	var effect_scene = score_normal_effect
	if point < 0 :
		effect_x = 0
		effect_dir = 0
		effect_col = $Paddles/PaddleAdriel.color
	
	if not locked:
		score += point
		locked = true
		set_display()
		if abs(score) >= target : effect_scene = score_victory_effect
	else :
		effect_scene = score_bounce_effect
	
	spawn_score_effect(effect_scene,effect_dir,effect_x,effect_col)


func start_game():
	$Ball.launch()
	set_display()


func set_display():
	$RetroBackground.display_score(float(score) / float(target))


func spawn_crown():
	var crown_effect_instance = crown_effect.instance()
	add_child(crown_effect_instance)
	if score > 0:
		crown_effect_instance.set_color($Paddles/PaddleAdriel.color)
	else:
		crown_effect_instance.set_color($Paddles/PaddleLuc.color)
		
func spawn_score_effect(scene, direction, x_position, color):
	var score_effect_instance = scene.instance()
	add_child(score_effect_instance)
	score_effect_instance.rotation_degrees = direction
	score_effect_instance.setup_color_ramps(color)
	score_effect_instance.position.y = $Ball.position.y
	score_effect_instance.position.x = x_position
