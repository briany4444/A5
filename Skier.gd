extends Area2D


#initializing variables
export var speed = 100
var direction = Vector2(180,0)
var xspeed=1
var selected = false
var tripped = false


#function that is called when object is instantiated
func _ready():
	#randomizing random variables
	randomize()
	#deciding if the skiier will move down and right or down and left
	if randi()%2:
		xspeed=-1
	else:
		xspeed=1


#function that is called every frame
func _process(delta):
	
	#if the player has tripped
	if tripped:
		isTripped()
	#if the player has been selected (drag or drop mechanic)
	elif selected:
		position.x = lerp(position.x, get_global_mouse_position().x,25*delta)
		direction.x=int(position.x/(speed*delta))
	#regular player movement code
	else:
		$AnimatedSprite.flip_h = xspeed<0
		direction.x+=xspeed
		direction.y+=1
		if (direction.length() > 0):
			direction = direction.normalized()
		position += direction*speed*delta



#Function that is called every second
func _on_DirectionTimer_timeout():
	print(1)
	#every 2 seconds, the skiier has a 1/2 chance that it will change x directions. however this is only applicable when the player is not selected nor tripped
	if randi() % 2 and not tripped and not selected:
		print(2)
		#player x speed changes direction
		xspeed=-xspeed


#Function that is called every 1.5 seconds		
func _on_TripTimer_timeout():
	#the skiier will have a 1/8 chance that it'll be in the trip state
	var ranNum= randi() % 8
	if ranNum==1 and not selected:
		#tripped state will be active and will switch the the tripped animation state
		tripped=true
		$AnimatedSprite.animation="Fallen"


#Function that is called when the skiier exits the screen
#func _on_VisibilityNotifier2D_screen_exited():
	#
	#queue_free()

func isTripped():
	pass#put health bar code here

#NEXT TO FUNCTIONS FOR DRAG AND DROP MECHANIC:


func _on_Skier_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") and not tripped:
		selected = true
		$AnimatedSprite.animation="Drag"
		
		
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed and not tripped:
			selected=false
			$AnimatedSprite.animation="Skiing"

