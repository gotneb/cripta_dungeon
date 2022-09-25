extends KinematicBody2D

const speed := 100
var direction := Vector2.ZERO


func _ready():
	$AnimatedSprite.play("default") 
	$Timer.start()


func _process(delta):
	_move(delta)


func _move(delta: float) -> void:
	direction = direction / direction.length()
	move_and_slide(direction * speed * delta * 100)


# Destroi pra n acupar espaco na memoria
func _on_Timer_timeout():
	queue_free()
