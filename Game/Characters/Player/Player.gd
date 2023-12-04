extends CharacterBody2D

class_name Player

const max_speed = 200
var input = Vector2.ZERO
var current_dir = "down"



func _physics_process(delta):
	player_movement(delta)
	

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	if (input.x > 0):
		current_dir = "right"
		play_anim(1)
	elif (input.x < 0):
		current_dir = "left"
		play_anim(1)
	elif (input.y > 0):
		current_dir = "down"
		play_anim(1)
	elif (input.y < 0):
		current_dir = "up"
		play_anim(1)
	else:
		play_anim(0)
	
	return input.normalized()

func player_movement(_delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		velocity = max_speed * input
	
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	match dir:
		"right":
			if movement == 1:
				anim.play("walk_right")
			elif movement == 0:
				anim.play("idle_right")
		"left":
			if movement == 1:
				anim.play("walk_left")
			elif movement == 0:
				anim.play("idle_left")
		"down":
			if movement == 1:
				anim.play("walk_down")
			elif movement == 0:
				anim.play("idle_down")
		"up":
			if movement == 1:
				anim.play("walk_up")
			elif movement == 0:
				anim.play("idle_up")

func player():
	pass
