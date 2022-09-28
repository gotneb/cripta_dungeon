extends KinematicBody2D

const speed := 100
var direction := Vector2.ZERO
var damage: int

func _ready():
	scale = Vector2(0.6, 0.6)
	$AnimatedSprite.play("default") 
	$Timer.start()
	
	var tween := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	# warning-ignore:return_value_discarded
	tween.tween_property(self, "scale", Vector2(1, 1), 0.5)


func _process(delta):
	_move(delta)


func _move(delta: float) -> void:
	direction = direction / direction.length()
	move_and_slide(direction * speed * delta * 100)


# Destroi pra nao acupar espaco na memoria
func _on_Timer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if body is OrcShaman:
		body.take_damage(damage)
		queue_free()
