extends Node

const target: = 3
var score: = 0
var locked: = true
var first_game: = true

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
		if first_game:
			start_game()
			first_game = false
		else:
			if $Crown.formed:
				start_game()
				$Crown.fade_out()


func adriel_touched(_body: Ball):
	score(-1)


func luc_touched(_body: Ball):
	score(1)


func reset_lock(_body: Ball):
	locked = false
	if abs(score) >= target:
		spawn_crown()
		score = 0
		$Ball.set_sleeping(true)


func score(point):
	if not locked:
		score += point
		locked = true
		set_display()

func start_game():
	$Ball.launch()
	set_display()

func set_display():
	$RetroBackground.display_score(float(score) / float(target))
	

func spawn_crown():
	var my_crown = preload("res://scenes/effects/Crown.tscn").instance()
	add_child(my_crown)
	if score > 0:
		$Crown.set_color($Paddles/PaddleAdriel.color)
	else:
		$Crown.set_color($Paddles/PaddleLuc.color)
