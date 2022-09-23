class_name Wizzard
extends KinematicBody2D

var speed := 40
var _velocity := Vector2.ZERO
var _flip_h := false

func _ready():
	$AnimatedSprite.play("idle")
	$AnimatedSprite.flip_h = _flip_h


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move(delta)


func _move(delta: float) -> void:
	_velocity = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	_velocity = move_and_slide(_velocity * speed * delta * 100)
	
	_play_animation()
	$AnimatedSprite.flip_h = _need_flip()


# Escolhe a animacao com base na velocidade
func _play_animation() -> void:
	var anim := ""
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
