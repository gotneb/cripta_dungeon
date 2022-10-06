class_name OrcShaman
extends KinematicBody2D

const damage_indicator_path := preload("res://scenes/interface/damage_indicator/damage_indicator.tscn")

signal health_changed(old_health, new_health)

onready var health_bar := $HealthBar
onready var animation := $AnimationPlayer
onready var hit_effect := $HitAnimated
onready var aim := $Aim

var max_hp := 20
var current_hp := max_hp

func _ready():
	$AnimatedSprite.play("idle")
	hit_effect.visible = false
	health_bar.set_max_health(max_hp)
	set_aim_visible_to(false)


# Da dano no inimigo
func take_damage(damage: int, direction: Vector2) -> void:
	animation.play("hitted")
	_show_hit()
	_dash(direction * 10)
	
	var old_health := current_hp
	current_hp -= damage
	
	# Morre
	if current_hp <= 0:
		current_hp = 0
		queue_free()
	
	health_bar.update_health(current_hp)
	emit_signal("health_changed", old_health, current_hp)


# Faz o inimigo recuar para uma determinada direcao
func _dash(v: Vector2) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", position + v, 1.5)


func set_aim_visible_to(state: bool) -> void:
	aim.visible = state


func _on_OrcShaman_health_changed(old_health, new_health):
	var di :DamageIndicator = damage_indicator_path.instance()
	add_child(di)
	di.goes_up(old_health - new_health)


func _show_hit() -> void:
	hit_effect.frame = 0
	hit_effect.visible = true
	hit_effect.play("default")


func _on_HitAnimated_animation_finished():
	hit_effect.visible = false
