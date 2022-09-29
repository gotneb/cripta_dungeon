extends KinematicBody2D


#-----------------------------------------------------Movimentação---------------------------------------------------#
var velocidade = Vector2.ZERO
var flip = false

const VEL_MAX = 120
const ACELERATE = 250
const ATRITO = 400
onready var animacaoplayer = $AnimatedSprite
onready var sword: Node2D = get_node("Sword")
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var sword_animation_player: AnimationPlayer = sword.get_node("SwordAnimationPlayer")
func _physics_process(delta):
	#Mecãnica: espada---#
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized() #posição do mouse
	sword.rotation = mouse_direction.angle()
	if sword.scale.y == 1 and mouse_direction.x < 0:
		sword.scale.y = -1
	elif sword.scale.y == -1 and mouse_direction.x > 0:
		sword.scale.y = 1 
		
	if Input.is_action_just_pressed("z_attack") and not sword_animation_player.is_playing():
		sword_animation_player.play("attack")
	#-------------------#
	
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
		
		
		
	
	#-----------------------------Fip horizontal Do Elfo Conforme a Direção do Mouse---------------------------------#
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		 animated_sprite.flip_h = true
	move_and_slide(velocidade)
	
