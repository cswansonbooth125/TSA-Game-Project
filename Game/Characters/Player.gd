extends CharacterBody2D

@export var move_speed : float = 100
@export var startingDirection : Vector2 = Vector2(0,1)

#parameters/walk/blend_position

@onready var animationTree = $AnimationTree

func _ready():
	animationTree.set("parameters/walk/blend_position", startingDirection)

func _physics_process(_delta):
	#get input direction
	var inputDirection = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(inputDirection)
	
	#update velocity
	velocity = inputDirection * move_speed
	#move and slide function
	move_and_slide()
	
func update_animation_parameters(moveInput : Vector2):
	if(moveInput != Vector2.ZERO):
		animationTree.set("parameters/walk/blend_position", moveInput)
