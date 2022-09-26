extends Control


func update_health(health: int) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property($TextureProgress, "value", float(health), 0.3)


func set_max_health(health: int) -> void:
	$TextureProgress.max_value = health
