extends CanvasLayer
class_name UI

@onready var health_label = $Health

var health = 3:
	set(new_health):
		health = new_health
# Called when the node enters the scene tree for the first time.


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
