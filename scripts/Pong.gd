extends Node

const target: = 3
var score: = 0
var locked: = true


func _process(delta):
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("increase") and score < target - 1:
		reset()
		score(1)
	if Input.is_action_just_pressed("decrease") and -score < target - 1:
		reset()
		score(-1)

	if $Ball.sleeping and Input.is_action_just_released("ui_accept"):
		if not $Crown:
			start_game()
		elif $Crown.fade_out():
			start_game()


func reset():
	locked = false
	if abs(score) >= target:
		spawn_crown()
		score = 0
		$Ball.stop()


func score(point):
	if not locked:
		score += point
		locked = true
		set_display()


func start_game():
	$Ball.launch()


func set_display():
	$RetroBackground.display_score(float(score) / float(target))


func spawn_crown():
	var MyCrown = preload("res://scenes/effects/Crown.tscn").instance()
	add_child(MyCrown)
	if score > 0:
		$Crown.set_color($Paddles/PaddleAdriel.color)
	else:
		$Crown.set_color($Paddles/PaddleLuc.color)


func _on_ScoreLock_body_entered(body):
	reset()


func _on_ScoreLuc_body_entered(body):
	score(-1)


func _on_ScoreAdriel_body_entered(body):
	score(1)
