extends CharacterBody2D

class_name Player

const max_speed = 500
var health = 3
var mana = 3
var dead = false
var enemy_attack_cooldown = true
var enemy_in_hitbox = false

var input = Vector2.ZERO
var current_dir = "down"

var spell_cooldown = true
var spell = preload("res://Scenes/spell_attack.tscn")

func _physics_process(delta):
	player_movement()
	enemy_attack()
	regenerate_mana()
	if health <= 0:
		dead = true
		
	
func player_movement():
	input = get_input()
	
	if input == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		velocity = max_speed * input
	
	move_and_slide()
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("left_mouse") and spell_cooldown and mana > 0:
		mana -= 1
		spell_cooldown = false
		var spell_instance = spell.instantiate()
		spell_instance.rotation = $Marker2D.rotation
		spell_instance.global_position = $Marker2D.global_position
		add_child(spell_instance)
		
		await get_tree().create_timer(0.2).timeout
		spell_cooldown = true

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

func _on_player_hitbox_body_entered(body):
	if body.is_in_group("enemy"):
		enemy_in_hitbox = true

func _on_player_hitbox_body_exited(body):
	if body.is_in_group("enemy"):
		enemy_in_hitbox = false

func enemy_attack():
	if enemy_in_hitbox and enemy_attack_cooldown:
		health -= 1
		enemy_attack_cooldown = false
		$Damage_cooldown.start()
		print(health)


func _on_damage_cooldown_timeout():
	enemy_attack_cooldown = true

func regenerate_mana():
	print(mana)
	if mana < 3:
		$Mana_cooldown.start()
		


func _on_mana_cooldown_timeout():
	if mana < 3:
		mana += 1
