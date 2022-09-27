class_name OrcShaman
extends KinematicBody2D

signal health_changed(old_health, new_health)

onready var health_bar := $HealthBar
onready var animation := $AnimationPlayer

var max_hp := 20
var current_hp := max_hp


func _ready():
	health_bar.set_max_health(max_hp)


func take_damage(damage: int) -> void:
	animation.play("hitted")
	var old_health := current_hp
	current_hp -= damage
	
	# Morre
	if current_hp <= 0:
		current_hp = 0
		queue_free()
	
	emit_signal("health_changed", old_health, current_hp)
	health_bar.update_health(current_hp)
