extends KinematicBody2D


var velocidade = Vector2.ZERO


# Called when the node enters the scene tree for all the time.
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector != Vector2.ZERO:
		velocidade = input_vector
	else:
		velocidade = Vector2.ZERO
		
	move_and_collide(velocidade)
