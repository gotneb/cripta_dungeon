extends Control


func update_health(health: int) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($TextureProgress, "value", float(health), 0.3)
	#$TextureProgress.value = health


func set_max_health(health: int) -> void:
	$TextureProgress.max_value = health
