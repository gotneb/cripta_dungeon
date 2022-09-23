class_name Player
extends KinematicBody2D

var speed := 40
var _velocity := Vector2.ZERO
var _flip_h:= false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move(delta)


func _move(delta: float) -> void:
	_velocity = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	_velocity = move_and_slide(_velocity * speed * delta * 100)
	
	if _velocity.x == 0:
		$Sprite.flip_h = _flip_h
	else:
		_flip_h = _velocity.x < 0
		$Sprite.flip_h = _flip_h
