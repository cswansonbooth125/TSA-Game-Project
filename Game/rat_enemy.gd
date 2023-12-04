extends CharacterBody2D

var speed = 50

var health = 100
var damage = 1

var dead = false
var player_in_area = false
var player

func _ready():
	dead = false

func _physics_process(delta):
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if player_in_area:
			velocity = global_position.direction_to(player.global_position)
			$AnimatedSprite2D.play("move")
		else:
			velocity = Vector2.ZERO
			$AnimatedSprite2D.play("idle")
			
	if dead:
		$detection_area/CollisionShape2D.disabled = true
	move_and_collide(velocity * speed * delta)

func _on_detection_area_body_entered(body):
	if body is Player:
		player_in_area = true
		player = body


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
		
