class_name Wizzard
extends KinematicBody2D

# Constantes
const fire_ball_path := preload("res://scenes/projectiles/wizzard/fire.tscn")

# Variaveis
var speed := 40
var _velocity := Vector2.ZERO
var _flip_h := false

func _ready():
	$AnimatedSprite.play("idle")
	$AnimatedSprite.flip_h = _flip_h


func _process(delta):
	_move(delta)

	if Input.is_action_just_pressed("attack"):
		$SpelsPositon.look_at(get_global_mouse_position())
		throw_fire_ball()


# Esssa funcao faz o personagem se mover
func _move(delta: float) -> void:
	# determina se move-se na direita ou equerda. Em seguida, determina se em cimao em baixo
	_velocity = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	# Aplica a velocidade no jogador
	_velocity = move_and_slide(_velocity * speed * delta * 100)
	
	_play_animation()
	$AnimatedSprite.flip_h = _need_flip()


# Escolhe a animacao com base na velocidade
func _play_animation() -> void:
	var anim : String
	if _velocity.x == 0:
		anim = "idle"
	else:
		anim = "run"
	
	if $AnimatedSprite.animation != anim:
		$AnimatedSprite.play(anim)


# Verifica se "flipa" a direcao do mago
func _need_flip() -> bool:
	if _velocity.x < 0:
		_flip_h = true
		return true
	elif _velocity.x > 0:
		_flip_h = false
		return false
	else:
		return _flip_h


# Arremessa uma bola de fogo
func throw_fire_ball() -> void:
	var fire := fire_ball_path.instance()
	fire.position = $SpelsPositon/Position.global_position
	fire.velocity =  get_global_mouse_position()
	fire.rotate($SpelsPositon.rotation)
	get_parent().add_child(fire)
