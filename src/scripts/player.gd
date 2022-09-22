class_name Player
extends KinematicBody2D

var speed := 20
var _velocity := Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move(delta)


func _move(delta: float) -> void:
	_velocity = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		)
	
	_velocity = move_and_slide(_velocity * speed * delta * 100)
