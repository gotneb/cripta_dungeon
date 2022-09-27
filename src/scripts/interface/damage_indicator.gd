class_name DamageIndicator
extends Node2D

onready var timer := $Timer

func _ready():
	scale = Vector2(0.1, 0.1)
	timer.connect("timeout", self, "on_timeout")
	timer.wait_time = 1.5
	timer.start()


func goes_up(damage: int) -> void:
	# Altera propriedades do tezto
	$Damage.text = str(damage)
	# =======================================
	# Anima propriedades de elevacao do texto
	# =======================================
	var time: float = 1
	# Sobe a texto de dano
	var pos: float = -25
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(self, "position:y", pos, time)
	# Aumenta a escala
	tween.parallel().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(0.3, 0.3), time + 0.2)
	# Diminui a visibilidade aos poucos
	tween.parallel().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate", Color("00ffffff"), time)


func on_timeout() -> void:
	queue_free()
