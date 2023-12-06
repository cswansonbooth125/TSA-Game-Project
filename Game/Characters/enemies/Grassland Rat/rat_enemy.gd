extends CharacterBody2D

var speed = 100
var health = 100

var dead = false
var player_in_area = false
var player
var current_dir = "right"

func _ready():
	dead = false

func _physics_process(delta):
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if player_in_area:
			velocity = global_position.direction_to(player.global_position)
			if velocity.x > 0:
				$AnimatedSprite2D.play("walk_right")
				current_dir = "right"
			else:
				$AnimatedSprite2D.play("walk_left")
				current_dir = "left"
		else:
			velocity = Vector2.ZERO
			if current_dir == "right":
				$AnimatedSprite2D.play("idle_right")
			else:
				$AnimatedSprite2D.play("idle_left")

	if dead:
		$detection_area/CollisionShape2D.disabled = true
	move_and_collide(velocity * speed * delta)

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true
		player = body
		$detection_area/CollisionShape2D.shape.radius = 300


func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
		$detection_area/CollisionShape2D.shape.radius = 150

func _on_hitbox_area_entered(area):
	var damage
	if area.has_method("spell_deal_damage"):
		damage = 50
		take_damage(damage)
		
func take_damage(damage):
	health -= damage
	if health <= 0 and !dead:
		death()


func death():
	dead = true
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(0.5).timeout
	queue_free()
	

