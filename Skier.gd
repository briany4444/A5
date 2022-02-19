extends Area2D

export var speed = 100
var direction = Vector2(180,100)
var xspeed=0

func _ready():
	randomize()
	if randi()%2:
		xspeed=-1
	else:
		xspeed=1

func _process(delta):
	direction.x+=xspeed
	direction.y+=1
	position = direction*speed*delta

func _on_DirectionTimer_timeout():
	randomize()
	if randi() % 2:
		xspeed=-xspeed


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
