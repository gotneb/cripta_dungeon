extends Area2D

# Isso da o efeito de ficar balancando de cima pra baixo
onready var positions := [global_position.y -5.0, global_position.y + 5.0] 


func _ready():
	_start_tween()


func _start_tween():
	$Tween.interpolate_property(self, "position:y",
	positions[0], positions[1], 1.5,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)    
	$Tween.start()


func _on_tween_completed(object, key):
	positions.invert()
	_start_tween()


func _on_Coin_body_entered(body):
	if body is Wizzard:
		hide()
		$CoinCollected.play()


func _on_CoinCollected_finished():
	queue_free()
