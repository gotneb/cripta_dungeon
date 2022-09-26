extends KinematicBody2D

#-----------------------------------------------------Movimentação---------------------------------------------------#
var velocidade = Vector2.ZERO
var flip = false

const VEL_MAX = 120
const ACELERATE = 250
const ATRITO = 400
onready var animacaoplayer = $AnimatedSprite

func _physics_process(delta):
	var result = Vector2.ZERO
	result.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	result.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	result = result.normalized()
	
	if result != Vector2.ZERO:
		animacaoplayer.play("run")
		velocidade = velocidade.move_toward(result * VEL_MAX, ACELERATE * delta)
	else:
		animacaoplayer.play("idle")
		velocidade = velocidade.move_toward(Vector2.ZERO, ATRITO * delta)
		 
	move_and_slide(velocidade)
	$AnimatedSprite.flip_h = _need_flip()
	
	#--------------------Verivicação de flip do personagem-----------------------------------------------------------#
func _need_flip() -> bool:
	if velocidade.x < 0:
		flip = true
		return true
	elif velocidade.x > 0:
		flip = false
		return false
	else:
		return flip
