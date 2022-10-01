class_name MagicSpell
extends KinematicBody2D

# Variaveis
export(int) var speed := 100
var direction := Vector2.ZERO
var damage: int

func _ready():
	$AnimatedSprite.play("default") 
	$Timer.start()


func _process(delta):
	_move(delta)


func _move(delta: float) -> void:
	direction = direction / direction.length()
	# warning-ignore:return_value_discarded
	move_and_slide(direction * speed * delta * 100)


func create_magic(pos: Vector2, dir: Vector2, rot: float, damage: int):
	self.position = pos
	self.direction =  dir
	self.rotate(rot)
	self.damage = damage
	return self


func _on_Timer_timeout():
	queue_free()


# Da dano em inimigos
func _on_HitBox_body_entered(body):
	if body is OrcShaman:
		body.take_damage(damage)
		queue_free()
