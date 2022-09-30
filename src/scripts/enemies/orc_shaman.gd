class_name OrcShaman
extends KinematicBody2D

const damage_indicator_path := preload("res://scenes/interface/damage_indicator/damage_indicator.tscn")

signal health_changed(old_health, new_health)

onready var health_bar := $HealthBar
onready var animation := $AnimationPlayer
onready var aim := $Aim

var max_hp := 20
var current_hp := max_hp

func _ready():
	$AnimatedSprite.play("idle")
	health_bar.set_max_health(max_hp)
	set_aim_visible_to(false)


# Da dano no inimigo
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


func set_aim_visible_to(state: bool) -> void:
	aim.visible = state


func _on_OrcShaman_health_changed(old_health, new_health):
	var di :DamageIndicator = damage_indicator_path.instance()
	add_child(di)
	di.goes_up(old_health - new_health)
