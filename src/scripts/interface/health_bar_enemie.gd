extends Control

onready var white_bar: TextureProgress = $WhiteBar
onready var red_bar: TextureProgress = $RedBar

func update_health(health: int) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT_IN)
	red_bar.value = health
	tween.tween_property(white_bar, "value", float(health), 0.3)


func set_max_health(health: int) -> void:
	red_bar.max_value = health
	white_bar.max_value = health
